(() => {
  'use strict';

  const parser = window.BlinkCollegeSchedule;
  const timetable = window.BLINK_COLLEGE_TIMETABLE;
  if (!parser || !timetable) {
    console.error('The local college schedule manager could not start.');
    return;
  }

  const $ = (id) => document.getElementById(id);
  const todayKey = () => {
    const date = new Date();
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
  };
  const escapeHtml = (value) => String(value ?? '').replace(/[&<>"']/g, (char) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  })[char]);
  let records = [];
  let draft = [];
  let storageError = '';
  let activeDate = '';

  function validRecord(record, requireId = true) {
    if (!record || typeof record !== 'object'
      || (requireId && typeof record.id !== 'string')
      || !['regular', 'exam', 'special', 'lab'].includes(record.scheduleType)
      || !Array.isArray(record.entries)
      || !record.entries.every((entry) => entry && typeof entry === 'object' && !Array.isArray(entry))) return false;
    const validDate = (value) => {
      if (value === null || value === undefined) return true;
      if (typeof value !== 'string' || !/^\d{4}-\d{2}-\d{2}$/.test(value)) return false;
      const [year, month, day] = value.split('-').map(Number);
      const date = new Date(year, month - 1, day);
      return date.getFullYear() === year && date.getMonth() === month - 1 && date.getDate() === day;
    };
    return validDate(record.effectiveFrom) && validDate(record.effectiveUntil)
      && (!record.effectiveFrom || !record.effectiveUntil || record.effectiveUntil >= record.effectiveFrom);
  }

  function setStatus(message, error = false) {
    const status = $('ttImportStatus');
    if (!status) return;
    status.textContent = message;
    status.classList.toggle('error', error);
  }

  function saveRecords(nextRecords) {
    try {
      localStorage.setItem(parser.STORAGE_KEY, JSON.stringify(nextRecords));
      records = nextRecords;
      storageError = '';
      applySchedule();
      renderHistory();
      return true;
    } catch (error) {
      console.error('Could not save college schedules locally', error);
      storageError = 'Could not save this schedule on the device. Check available storage and try again.';
      setStatus(storageError, true);
      return false;
    }
  }

  function loadRecords() {
    let raw;
    try {
      raw = localStorage.getItem(parser.STORAGE_KEY);
      if (raw !== null) {
        const value = JSON.parse(raw);
        if (!Array.isArray(value)) throw new Error('Saved college schedules must be an array.');
        if (!value.every((record) => validRecord(record))) throw new Error('One or more saved schedules are invalid.');
        records = value;
        return;
      }
      const seedEntries = timetable.schedule.map((item) => ({ ...item }));
      records = [{
        id: `migrated-initial-${Date.now()}`,
        scheduleType: 'regular',
        name: 'Initial college timetable',
        effectiveFrom: todayKey(),
        effectiveUntil: null,
        entries: seedEntries,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
        source: 'bundled-initial-data',
      }];
      localStorage.setItem(parser.STORAGE_KEY, JSON.stringify(records));
    } catch (error) {
      console.error('Could not load college schedules', error);
      storageError = 'Saved schedules could not be read. They have not been replaced; check device storage.';
      setStatus(storageError, true);
      records = [];
    }
  }

  function applySchedule() {
    activeDate = todayKey();
    timetable.schedule.splice(0, timetable.schedule.length,
      ...(records.length ? parser.getVisibleEntries(records, activeDate) : []).map((entry) => ({ ...entry })));
    window.blinkCollegeTimetable?.refreshFromSchedules();
    renderExamToday();
  }

  function openManager() {
    if (typeof window.openCollegeTimetable === 'function') window.openCollegeTimetable('manager');
    else $('ttViewManager')?.removeAttribute('hidden');
    renderHistory();
  }

  function normalizeWarnings(entry) {
    const warnings = Array.isArray(entry.warnings) ? entry.warnings : [];
    entry.warnings = warnings.filter((warning) => {
      if (warning.includes('End time needs confirmation')) return !entry.endTime;
      if (warning.includes('Exam date is required')) return !entry.date;
      if (warning.includes('Duplicate class') || warning.startsWith('Overlaps ')) return false;
      if (warning.includes('Weekday does not match the detected date')) {
        if (!entry.date || !parser.DAYS.includes(entry.day)) return false;
        const [year, month, day] = entry.date.split('-').map(Number);
        return parser.DAYS[(new Date(year, month - 1, day).getDay() + 6) % 7] !== entry.day;
      }
      if (warning.includes('Confirm AM/PM for start time') || warning.includes('Confirm AM/PM for end time')) return true;
      if (warning.includes('Unknown course code') || warning.includes('Unrecognized course') || warning.includes('Choose a course')) {
        return !entry.courseId;
      }
      if (warning.includes('Weekday is missing') || warning.includes('Unknown weekday')) return !parser.DAYS.includes(entry.day);
      if (warning.includes('Invalid start time')) return !entry.startTime;
      if (warning.includes('Invalid end time')) return !entry.endTime;
      return true;
    });
  }

  function warningList(entry, index) {
    const validation = parser.validateEntry(entry);
    const duplicateWarnings = [];
    draft.slice(0, index).forEach((previous) => {
      if (entry.day !== previous.day || entry.date !== previous.date) return;
      if (entry.startTime === previous.startTime && entry.endTime === previous.endTime
        && entry.courseId === previous.courseId && entry.courseName === previous.courseName) {
        duplicateWarnings.push('Duplicate class');
      } else if (entry.startTime && entry.endTime && previous.startTime && previous.endTime
        && entry.startTime < previous.endTime && previous.startTime < entry.endTime) {
        duplicateWarnings.push(`Overlaps ${previous.startTime}–${previous.endTime}`);
      }
    });
    return { errors: validation.errors, warnings: [...new Set([...validation.warnings, ...duplicateWarnings])] };
  }

  function courseOptions(selected) {
    return `<option value="">Choose course</option>${Object.entries(timetable.courses).map(([id, course]) =>
      `<option value="${escapeHtml(id)}"${id === selected ? ' selected' : ''}>${escapeHtml(course.courseCode)} · ${escapeHtml(course.courseName)}</option>`).join('')}<option value="custom"${selected && !timetable.courses[selected] ? ' selected' : ''}>Other / enter name</option>`;
  }

  function reviewEntryMarkup(entry, index) {
    normalizeWarnings(entry);
    const messages = warningList(entry, index);
    const alerts = [
      ...messages.errors.map((message) => `<li class="tt-review-error">${escapeHtml(message)}</li>`),
      ...messages.warnings.map((message) => `<li>${escapeHtml(message)}</li>`),
    ].join('');
    const selectedType = entry.kind === 'exam' ? 'exam' : entry.kind === 'lunch' ? 'lunch' : entry.kind === 'break' || entry.kind === 'free' ? 'break' : entry.isLab ? 'lab' : 'class';
    const selectedCourse = entry.courseId && timetable.courses[entry.courseId] ? entry.courseId : '';
    return `<article class="tt-review-entry" data-review-entry="${index}">
      <div class="tt-review-entry-head"><strong>Entry ${index + 1}</strong><button type="button" data-delete-entry="${index}" aria-label="Delete entry">Delete</button></div>
      ${alerts ? `<ul class="tt-review-alerts">${alerts}</ul>` : '<p class="tt-review-ok">✓ Ready to save</p>'}
      <div class="tt-review-fields">
       <label>Weekday<select data-entry-field="day"><option value="">Choose day</option>${parser.DAYS.map((day) => `<option value="${day}"${entry.day === day ? ' selected' : ''}>${day}</option>`).join('')}</select></label>
       <label>Date (optional)<input data-entry-field="date" type="date" value="${escapeHtml(entry.date || '')}"></label>
       <label>Start<input data-entry-field="startTime" type="time" value="${escapeHtml(entry.startTime || '')}"></label>
       <label>End<input data-entry-field="endTime" type="time" value="${escapeHtml(entry.endTime || '')}"></label>
       <label>Course<select data-entry-field="courseId">${courseOptions(selectedCourse || (entry.courseName ? 'custom' : ''))}</select></label>
       <label>Course name<input data-entry-field="courseName" type="text" value="${escapeHtml(entry.courseName || '')}" placeholder="Course or subject"></label>
       <label>Course code<input data-entry-field="courseCode" type="text" value="${escapeHtml(entry.courseCode || '')}" placeholder="Optional code"></label>
       <label>Room / venue<input data-entry-field="location" type="text" value="${escapeHtml(entry.location || '')}" placeholder="Room or venue"></label>
       <label>Type<select data-entry-field="kind"><option value="class"${selectedType === 'class' ? ' selected' : ''}>Class</option><option value="lab"${selectedType === 'lab' ? ' selected' : ''}>Lab</option><option value="exam"${selectedType === 'exam' ? ' selected' : ''}>Exam</option><option value="break"${selectedType === 'break' ? ' selected' : ''}>Break</option><option value="lunch"${selectedType === 'lunch' ? ' selected' : ''}>Lunch</option></select></label>
       ${selectedType === 'exam' || $('ttScheduleType')?.value === 'exam' ? `<label>Exam type<input data-entry-field="examType" type="text" value="${escapeHtml(entry.examType || '')}" placeholder="Final, mid-term…"></label><label>Notes<input data-entry-field="notes" type="text" value="${escapeHtml(entry.notes || '')}" placeholder="Additional notes"></label>` : ''}
      </div>
    </article>`;
  }

  function renderReview() {
    const panel = $('ttReviewPanel');
    if (!panel) return;
    panel.hidden = false;
    $('ttReviewTitle').textContent = `Review ${draft.length} ${draft.length === 1 ? 'entry' : 'entries'}`;
    $('ttReviewSummary').textContent = 'Check highlighted items, edit any field, then save only when the entries are correct.';
    $('ttReviewEntries').innerHTML = draft.length
      ? draft.map(reviewEntryMarkup).join('')
      : '<div class="tt-empty">No entries yet. Add an entry or paste timetable text above.</div>';
    $('ttReviewEntries').querySelectorAll('[data-delete-entry]').forEach((button) => {
      button.addEventListener('click', () => {
        draft.splice(Number(button.dataset.deleteEntry), 1);
        renderReview();
      });
    });
    $('ttReviewEntries').querySelectorAll('[data-entry-field]').forEach((control) => {
      control.addEventListener('change', () => {
        const card = control.closest('[data-review-entry]');
        const entry = draft[Number(card.dataset.reviewEntry)];
        const field = control.dataset.entryField;
        if (field === 'courseId') {
          entry.courseId = control.value === 'custom' ? '' : control.value;
          if (entry.courseId) {
            const course = timetable.courses[entry.courseId];
            entry.courseName = course.courseName;
            entry.courseCode = course.courseCode;
          }
        } else if (field === 'kind') {
          entry.kind = control.value === 'lab' ? 'class' : control.value;
          entry.isLab = control.value === 'lab';
          if (control.value === 'exam') entry.scheduleType = 'exam';
        } else {
          entry[field] = control.value;
          if (field === 'courseName') entry.courseId = '';
          if (field === 'startTime') entry.warnings = entry.warnings.filter((warning) => !warning.includes('Confirm AM/PM for start time'));
          if (field === 'endTime') entry.warnings = entry.warnings.filter((warning) => !warning.includes('Confirm AM/PM for end time'));
        }
        normalizeWarnings(entry);
        renderReview();
      });
    });
  }

  function parseText() {
    const type = $('ttScheduleType').value;
    const periodMinutes = Number($('ttPeriodMinutes').value) || undefined;
    const result = parser.parseTimetableText($('ttScheduleText').value, {
      courses: timetable.courses,
      knownPeriods: timetable.schedule,
      periodMinutes,
    });
    draft = result.entries.map((entry) => {
      const parsed = { ...entry, warnings: [...entry.warnings] };
      if (type === 'exam') {
        parsed.kind = 'exam';
        parsed.scheduleType = 'exam';
        parsed.examType ||= 'Exam';
        if (!parsed.date) parsed.warnings.push('Exam date is required');
      }
      if (type === 'lab') {
        parsed.isLab = true;
        parsed.kind = 'class';
      }
      return parsed;
    });
    const skipped = result.issues.length ? ` ${result.issues.length} line(s) need attention.` : '';
    setStatus(`Detected ${draft.length} ${draft.length === 1 ? 'entry' : 'entries'} locally.${skipped}${result.issues.map((issue) => ` Line ${issue.line}: ${issue.message}`).join('')}`);
    renderReview();
  }

  function addEntry() {
    const type = $('ttScheduleType').value;
    draft.push({
      id: `manual-${Date.now()}-${draft.length}`,
      day: '',
      date: '',
      startTime: '',
      endTime: '',
      courseId: '',
      courseName: '',
      courseCode: '',
      kind: type === 'exam' ? 'exam' : 'class',
      scheduleType: type,
      isLab: type === 'lab',
      location: '',
      examType: type === 'exam' ? 'Exam' : '',
      notes: '',
      warnings: [],
    });
    renderReview();
  }

  function saveDraft() {
    if (storageError) return setStatus(storageError, true);
    if (!draft.length) return setStatus('Add at least one entry before saving.', true);
    const type = $('ttScheduleType').value;
    const effectiveFrom = $('ttEffectiveFrom').value;
    const effectiveUntil = $('ttEffectiveUntil').value || null;
    if (!effectiveFrom) return setStatus('Choose the date this schedule becomes effective.', true);
    if (effectiveUntil && effectiveUntil < effectiveFrom) return setStatus('Effective until must be on or after effective from.', true);

    const invalid = [];
    draft.forEach((entry, index) => {
      normalizeWarnings(entry);
      const issues = parser.validateEntry(entry);
      if ((type === 'exam' || entry.kind === 'exam') && !entry.date) issues.errors.push('Choose the exam date');
      if (!['break', 'lunch', 'free'].includes(entry.kind) && !entry.courseName && !entry.courseId) issues.errors.push('Choose or enter a subject');
      if (issues.errors.length) invalid.push(`Entry ${index + 1}: ${[...new Set(issues.errors)].join(', ')}`);
    });
    if (invalid.length) {
      setStatus(`Fix required fields before saving. ${invalid.join(' · ')}`, true);
      renderReview();
      return;
    }
    const now = new Date().toISOString();
    const savedEntries = draft.map((entry) => {
      const { warnings, sourceLine, ...saved } = entry;
      const isExam = type === 'exam' || saved.kind === 'exam';
      return {
        ...saved,
        kind: isExam ? 'exam' : saved.kind,
        scheduleType: isExam ? 'exam' : type,
        isLab: type === 'lab' || saved.isLab || saved.kind === 'lab',
      };
    });
    const groupedEntries = new Map();
    savedEntries.forEach((entry) => {
      const scheduleType = entry.kind === 'exam' ? 'exam' : type;
      groupedEntries.set(scheduleType, [...(groupedEntries.get(scheduleType) || []), entry]);
    });
    const nextRecords = [...records];
    groupedEntries.forEach((entries, scheduleType) => {
      const dayBefore = new Date(`${effectiveFrom}T00:00:00`);
      dayBefore.setDate(dayBefore.getDate() - 1);
      const cutoff = `${dayBefore.getFullYear()}-${String(dayBefore.getMonth() + 1).padStart(2, '0')}-${String(dayBefore.getDate()).padStart(2, '0')}`;
      for (let index = 0; index < nextRecords.length; index += 1) {
        const record = nextRecords[index];
        if (record.scheduleType !== scheduleType || !record.effectiveFrom || record.effectiveFrom > effectiveFrom
          || (record.effectiveUntil && record.effectiveUntil < effectiveFrom)) continue;
        nextRecords[index] = { ...record, effectiveUntil: cutoff, updatedAt: now };
      }
      nextRecords.push({
        id: `schedule-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
        scheduleType,
        name: parser.TYPE_NAMES[scheduleType],
        effectiveFrom,
        effectiveUntil,
        entries,
        createdAt: now,
        updatedAt: now,
      });
    });
    if (!saveRecords(nextRecords)) return;
    draft = [];
    $('ttReviewPanel').hidden = true;
    setStatus(`${parser.TYPE_NAMES[type]} saved on this device.`);
  }

  function renderHistory() {
    const container = $('ttScheduleHistory');
    if (!container) return;
    if (storageError && !records.length) {
      container.innerHTML = `<p class="tt-manager-status error">${escapeHtml(storageError)}</p>`;
      return;
    }
    container.innerHTML = records.length ? [...records].sort((a, b) =>
      String(b.effectiveFrom || '').localeCompare(String(a.effectiveFrom || ''))
      || String(b.updatedAt || '').localeCompare(String(a.updatedAt || ''))).map((record) => {
      const range = `${record.effectiveFrom || 'Always'} → ${record.effectiveUntil || 'Onwards'}`;
      return `<article class="tt-history-item"><div><strong>${escapeHtml(record.name || parser.TYPE_NAMES[record.scheduleType])}</strong><small>${escapeHtml(range)} · ${record.entries.length} entries</small></div><div class="tt-history-actions"><button type="button" data-history-action="view" data-history-id="${escapeHtml(record.id)}">View</button><button type="button" data-history-action="restore" data-history-id="${escapeHtml(record.id)}">Restore</button><button type="button" data-history-action="duplicate" data-history-id="${escapeHtml(record.id)}">Duplicate</button><button type="button" data-history-action="delete" data-history-id="${escapeHtml(record.id)}">Delete</button></div></article>`;
    }).join('') : '<div class="tt-empty">No saved schedules.</div>';
    container.querySelectorAll('[data-history-action]').forEach((button) => {
      button.addEventListener('click', () => historyAction(button.dataset.historyAction, button.dataset.historyId));
    });
  }

  function historyAction(action, id) {
    const record = records.find((item) => item.id === id);
    if (!record) return;
    if (action === 'view') {
      $('ttScheduleType').value = record.scheduleType;
      draft = record.entries.map((entry) => ({ ...entry, warnings: [] }));
      $('ttEffectiveFrom').value = record.effectiveFrom || todayKey();
      $('ttEffectiveUntil').value = record.effectiveUntil || '';
      renderReview();
      return;
    }
    if (action === 'delete') {
      if (!window.confirm(`Delete this ${record.name || 'schedule'} from history?`)) return;
      saveRecords(records.filter((item) => item.id !== id));
      setStatus('Schedule deleted from history.');
      return;
    }
    const from = todayKey();
    const copy = {
      ...record,
      id: `schedule-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
      name: action === 'restore' ? `${record.name || parser.TYPE_NAMES[record.scheduleType]} (restored)` : `${record.name || parser.TYPE_NAMES[record.scheduleType]} (copy)`,
      effectiveFrom: from,
      effectiveUntil: null,
      entries: record.entries.map((entry) => ({ ...entry, id: `entry-${Date.now()}-${Math.random().toString(36).slice(2, 7)}` })),
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    const next = records.map((previous) => {
      if (previous.scheduleType !== copy.scheduleType || !previous.effectiveFrom || previous.effectiveFrom > from
        || (previous.effectiveUntil && previous.effectiveUntil < from)) return previous;
      const dayBefore = new Date(`${from}T00:00:00`);
      dayBefore.setDate(dayBefore.getDate() - 1);
      const until = `${dayBefore.getFullYear()}-${String(dayBefore.getMonth() + 1).padStart(2, '0')}-${String(dayBefore.getDate()).padStart(2, '0')}`;
      return { ...previous, effectiveUntil: until, updatedAt: new Date().toISOString() };
    });
    next.push(copy);
    if (saveRecords(next)) setStatus(action === 'restore' ? 'Previous schedule restored as a new active version.' : 'Schedule duplicated. The original remains in history.');
  }

  function exportSchedule() {
    const backup = { formatVersion: 1, exportedAt: new Date().toISOString(), schedules: records };
    const json = JSON.stringify(backup, null, 2);
    if (window.BlinkNative?.saveScheduleBackup) {
      window.BlinkNative.saveScheduleBackup('blink-schedules.json', json);
      setStatus('Schedule backup requested. Choose where to save the JSON file.');
      return;
    }
    const url = URL.createObjectURL(new Blob([json], { type: 'application/json' }));
    const link = document.createElement('a');
    link.href = url;
    link.download = 'blink-schedules.json';
    link.click();
    URL.revokeObjectURL(url);
    setStatus('Schedule JSON exported.');
  }

  function importScheduleFile(file) {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      try {
        const parsed = JSON.parse(String(reader.result || ''));
        const imported = Array.isArray(parsed) ? parsed : Array.isArray(parsed.schedules) ? parsed.schedules : [parsed];
        const valid = imported.filter((record) => validRecord(record, false));
        if (!valid.length || valid.length !== imported.length) throw new Error('The JSON file does not contain valid BLINK schedule records.');
        const now = new Date().toISOString();
        const copies = valid.map((record) => ({
          ...record,
          id: `import-${Date.now()}-${Math.random().toString(36).slice(2, 9)}`,
          entries: record.entries.map((entry) => ({ ...entry, id: `entry-${Date.now()}-${Math.random().toString(36).slice(2, 8)}` })),
          createdAt: now,
          updatedAt: now,
        }));
        if (saveRecords([...records, ...copies])) setStatus(`Imported ${copies.length} schedule(s). Existing history was kept.`);
      } catch (error) {
        console.error('Could not import schedule backup', error);
        setStatus(error instanceof Error ? error.message : 'Could not read this schedule backup.', true);
      }
    };
    reader.onerror = () => setStatus('Could not read the selected JSON file.', true);
    reader.readAsText(file);
  }

  function renderExamToday() {
    const panels = [$('ttExamToday'), $('ttExamTodaySummary')].filter(Boolean);
    if (!panels.length) return;
    const today = todayKey();
    const exams = records.filter((record) => record.scheduleType === 'exam').flatMap((record) =>
      record.entries.filter((entry) => entry.date && entry.date >= today
        && (!record.effectiveFrom || record.effectiveFrom <= entry.date)
        && (!record.effectiveUntil || record.effectiveUntil >= entry.date))
        .map((entry) => ({ ...entry, schedule: record })))
      .sort((a, b) => `${a.date} ${a.startTime}`.localeCompare(`${b.date} ${b.startTime}`));
    const todayExams = exams.filter((exam) => exam.date === today);
    const next = exams.find((exam) => exam.date > today);
    if (!todayExams.length && !next) {
      panels.forEach((panel) => { panel.hidden = true; });
      return;
    }
    panels.forEach((panel) => { panel.hidden = false; });
    const markup = (exam, label) => `<div class="tt-exam-item"><span>${escapeHtml(label)} · ${escapeHtml(exam.date)} · ${escapeHtml(exam.startTime || 'Time not set')}${exam.endTime ? `–${escapeHtml(exam.endTime)}` : ''}</span><strong>${escapeHtml(exam.courseName || exam.courseCode || 'Exam')}</strong><small>${escapeHtml([exam.examType, exam.location && `Venue: ${exam.location}`, exam.notes].filter(Boolean).join(' · '))}</small></div>`;
    panels.forEach((panel) => {
      panel.innerHTML = `<h3>Exam timetable</h3>${todayExams.map((exam) => markup(exam, 'Today')).join('')}${next ? markup(next, 'Upcoming exam') : ''}`;
    });
  }

  function importOcrText(text) {
    $('ttScheduleText').value = text;
    setStatus('Text extracted on this device. Review the parsed entries before saving.');
    parseText();
    openManager();
  }

  function onOcrError(message) {
    setStatus(message || 'On-device text recognition failed.', true);
    openManager();
  }

  function onBackupResult(success, message) {
    setStatus(message || (success ? 'Schedule backup saved.' : 'Could not save the schedule backup.'), !success);
  }

  function requestScheduleFile(kind) {
    if (window.BlinkNative?.selectScheduleFile) {
      window.BlinkNative.selectScheduleFile(kind);
      setStatus(`Choose a timetable ${kind} to run on-device OCR.`);
      return;
    }
    $('ttScheduleFile')?.click();
  }

  function onNativePickerError(message) {
    setStatus(message || 'No file picker is available on this device.', true);
  }

  $('ttParseText')?.addEventListener('click', parseText);
  $('ttAddEntry')?.addEventListener('click', addEntry);
  $('ttSaveSchedule')?.addEventListener('click', saveDraft);
  $('ttCancelReview')?.addEventListener('click', () => { draft = []; $('ttReviewPanel').hidden = true; });
  $('ttScheduleImage')?.addEventListener('click', () => requestScheduleFile('image'));
  $('ttSchedulePdf')?.addEventListener('click', () => requestScheduleFile('pdf'));
  $('ttScheduleFile')?.addEventListener('change', () => {
    const file = $('ttScheduleFile').files?.[0];
    if (file && !window.BlinkNative?.showNotification) {
      setStatus('Local image/PDF OCR is available in the Android app. This browser cannot run its on-device OCR integration.', true);
    }
    $('ttScheduleFile').value = '';
  });
  $('ttExportSchedule')?.addEventListener('click', exportSchedule);
  $('ttImportSchedule')?.addEventListener('click', () => $('ttScheduleBackupFile')?.click());
  $('ttScheduleBackupFile')?.addEventListener('change', () => {
    importScheduleFile($('ttScheduleBackupFile').files?.[0]);
    $('ttScheduleBackupFile').value = '';
  });
  $('ttScheduleType')?.addEventListener('change', () => {
    if (draft.length) renderReview();
  });
  window.openCollegeScheduleManager = openManager;
  window.BlinkCollegeScheduleManager = {
    importOcrText,
    onOcrError,
    onBackupResult,
    onNativePickerError,
    refresh: applySchedule,
    entriesForDate: (date) => parser.getVisibleEntries(records, date),
  };

  loadRecords();
  applySchedule();
  renderHistory();
  $('ttEffectiveFrom').value = todayKey();
  $('ttReviewPanel').hidden = true;
  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') {
      try {
        const latest = JSON.parse(localStorage.getItem(parser.STORAGE_KEY) || '[]');
        if (!Array.isArray(latest) || !latest.every((record) => validRecord(record))) {
          throw new Error('The saved schedule data is not in a supported format.');
        }
        if (JSON.stringify(latest) !== JSON.stringify(records)) {
          records = latest;
          applySchedule();
          renderHistory();
        }
      } catch (error) {
        console.error('Could not refresh saved college schedules', error);
        setStatus('Could not refresh saved college schedules.', true);
      }
    }
  });
  setInterval(() => {
    if (document.visibilityState === 'visible' && todayKey() !== activeDate) applySchedule();
  }, 60000);
})();
