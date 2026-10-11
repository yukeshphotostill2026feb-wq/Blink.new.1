(function (root, factory) {
  const api = factory();
  if (typeof module === 'object' && module.exports) module.exports = api;
  if (root) root.BlinkCollegeSchedule = api;
})(typeof window !== 'undefined' ? window : globalThis, function () {
  'use strict';

  const STORAGE_KEY = 'blinkCollegeSchedules';
  const DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const WEEKDAYS = {
    mon: 'Monday', monday: 'Monday',
    tue: 'Tuesday', tues: 'Tuesday', tuesday: 'Tuesday',
    wed: 'Wednesday', weds: 'Wednesday', wednesday: 'Wednesday',
    thu: 'Thursday', thur: 'Thursday', thurs: 'Thursday', thursday: 'Thursday',
    fri: 'Friday', friday: 'Friday',
    sat: 'Saturday', saturday: 'Saturday',
    sun: 'Sunday', sunday: 'Sunday',
  };
  const TYPE_NAMES = {
    regular: 'Regular Timetable',
    exam: 'Exam Timetable',
    special: 'Special/Changed Timetable',
    lab: 'Lab Schedule',
  };

  function normalizeCode(value) {
    return String(value || '').toUpperCase().replace(/[^A-Z0-9]/g, '');
  }

  function findCourse(text, courses) {
    const normalized = String(text || '').toLowerCase();
    const codes = Object.entries(courses).flatMap(([id, course]) => [
      { id, course, code: course.courseCode },
      { id, course, code: id },
    ]).sort((a, b) => b.code.length - a.code.length);
    const knownCode = codes.find(({ code }) => new RegExp(`(?:^|[^a-z0-9])${code.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(?:$|[^a-z0-9])`, 'i').test(normalized));
    if (knownCode) {
      return { course: knownCode.course, courseId: knownCode.id, code: knownCode.course.courseCode, byCode: true };
    }
    const candidates = Object.entries(courses)
      .sort((a, b) => b[1].courseName.length - a[1].courseName.length);
    const match = candidates.find(([, course]) => normalized.includes(course.courseName.toLowerCase()));
    return match
      ? { course: match[1], courseId: match[0], code: match[1].courseCode, byCode: false }
      : { course: null, courseId: '', code: '', byCode: false };
  }

  function parseDate(input, referenceYear = new Date().getFullYear()) {
    const text = String(input || '').trim();
    let match = text.match(/\b(20\d{2})-(\d{1,2})-(\d{1,2})\b/);
    if (match) return validDateKey(Number(match[1]), Number(match[2]), Number(match[3]));
    match = text.match(/\b(\d{1,2})[/.](\d{1,2})[/.](20\d{2})\b/);
    if (match) return validDateKey(Number(match[3]), Number(match[2]), Number(match[1]));
    match = text.match(/\b(\d{1,2})(?:st|nd|rd|th)?\s+(Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)(?:\s+(20\d{2}))?\b/i);
    if (match) {
      const month = new Date(`${match[2]} 1, 2000`).getMonth() + 1;
      return validDateKey(Number(match[3] || referenceYear), month, Number(match[1]));
    }
    match = text.match(/\b(Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\s+(\d{1,2})(?:st|nd|rd|th)?(?:,?\s+(20\d{2}))?\b/i);
    if (match) {
      const month = new Date(`${match[1]} 1, 2000`).getMonth() + 1;
      return validDateKey(Number(match[3] || referenceYear), month, Number(match[2]));
    }
    return '';
  }

  function validDateKey(year, month, day) {
    const date = new Date(year, month - 1, day);
    if (date.getFullYear() !== year || date.getMonth() !== month - 1 || date.getDate() !== day) return '';
    return `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
  }

  function parseClock(raw) {
    const match = String(raw || '').trim().match(/^(\d{1,2})(?:[:.](\d{2}))?\s*(am|pm)?$/i);
    if (!match) return { time: '', valid: false, ambiguous: false };
    let hour = Number(match[1]);
    const minute = Number(match[2] || 0);
    const meridiem = (match[3] || '').toLowerCase();
    if (minute > 59 || hour > (meridiem ? 12 : 23) || hour < 0 || (meridiem && hour === 0)) {
      return { time: '', valid: false, ambiguous: false };
    }
    const ambiguous = !meridiem && hour >= 1 && hour <= 6;
    if (meridiem) hour = (hour % 12) + (meridiem === 'pm' ? 12 : 0);
    return { time: `${String(hour).padStart(2, '0')}:${String(minute).padStart(2, '0')}`, valid: true, ambiguous };
  }

  function parseTimetableText(text, options = {}) {
    const courses = options.courses || {};
    const entries = [];
    const issues = [];
    let currentDay = '';
    let currentDate = '';
    let sequence = 0;

    String(text || '').split(/\r?\n/).forEach((sourceLine, lineIndex) => {
      let line = sourceLine.trim().replace(/^[•*\-\u2022]\s*/, '');
      if (!line) return;
      const firstWord = line.match(/^([A-Za-z]+)\b/);
      const dayToken = firstWord?.[1]?.toLowerCase();
      const detectedDay = dayToken ? WEEKDAYS[dayToken] : '';
      const previousDay = currentDay;
      if (detectedDay) {
        currentDay = detectedDay;
        if (detectedDay !== previousDay) currentDate = '';
        line = line.slice(firstWord[0].length).replace(/^[\s,:/-]+/, '');
      }

      const parsedDate = parseDate(line, options.referenceYear);
      const unknownWeekday = Boolean(dayToken && !detectedDay && !parsedDate
        && /\d{1,2}(?:[:.]\d{2})?\s*(?:am|pm)?/i.test(line));
      let dateWeekdayMismatch = false;
      if (parsedDate) {
        currentDate = parsedDate;
        const [year, month, day] = parsedDate.split('-').map(Number);
        const dateDay = DAYS[(new Date(year, month - 1, day).getDay() + 6) % 7];
        dateWeekdayMismatch = Boolean(detectedDay && detectedDay !== dateDay);
        if (!detectedDay) currentDay = dateDay;
        line = line.replace(/\b(?:20\d{2}-\d{1,2}-\d{1,2}|\d{1,2}[/.]\d{1,2}[/.]20\d{2}|\d{1,2}(?:st|nd|rd|th)?\s+(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)(?:\s+20\d{2})?|(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\s+\d{1,2}(?:st|nd|rd|th)?(?:,?\s+20\d{2})?)\b/i, '').trim();
      }

      const detectedLocation = line.match(/\b(?:room|location|venue)\s*[:#-]?\s*([^,;|]+)/i)
        || line.match(/\b((?:LH|Lab(?:oratory)?|Room|Hall|Block|Auditorium|Building)\s*[A-Z0-9-]+)\b/i);
      const timeLine = detectedLocation ? line.replace(detectedLocation[0], ' ') : line;
      const range = timeLine.match(/(\d{1,2}(?:[:.]\d{2})?\s*(?:am|pm)?)\s*(?:-|–|—|\bto\b)\s*(\d{1,2}(?:[:.]\d{2})?\s*(?:am|pm)?)/i);
      const clockPattern = /\b\d{1,2}(?:[:.]\d{2})?\s*(?:am|pm)?\b/ig;
      const clocks = timeLine.match(clockPattern) || [];
      const startRaw = range ? range[1] : clocks[0];
      const endRaw = range ? range[2] : clocks.length > 1 ? clocks[1] : '';
      if (!startRaw) {
        if (detectedDay) return;
        if (/^(?:sun|mon|tue|wed|thu|fri|sat)/i.test(sourceLine.trim())) {
          issues.push({ line: lineIndex + 1, message: `Could not find a valid time: "${sourceLine.trim()}"` });
        }
        return;
      }

      const start = parseClock(startRaw);
      const end = endRaw ? parseClock(endRaw) : null;
      const warnings = [];
      let day = unknownWeekday ? '' : currentDay;
      if (unknownWeekday) {
        warnings.push(`Unknown weekday "${firstWord[1]}"`);
      } else if (!day) {
        warnings.push('Weekday is missing');
      }
      if (!start.valid) warnings.push('Invalid start time');
      if (start.ambiguous) warnings.push('Confirm AM/PM for start time');
      if (end && !end.valid) warnings.push('Invalid end time');
      if (end?.ambiguous) warnings.push('Confirm AM/PM for end time');
      if (dateWeekdayMismatch) warnings.push('Weekday does not match the detected date');

      const startTime = start.valid ? start.time : '';
      let endTime = end?.valid ? end.time : '';
      const remainder = timeLine
        .replace(range || startRaw, ' ')
        .replace(clockPattern, ' ')
        .replace(/\b(?:room|location|venue)\s*[:#-]?\s*/ig, ' ')
        .trim();
      const code = remainder.match(/\b(?:\d{2})?[A-Z]{1,5}\d{2,3}\b/i)?.[0] || '';
      const matched = findCourse(remainder, courses);
      const isLab = /\blab(?:oratory)?\b/i.test(remainder);
      const isExam = /\b(exam|examination|mid[\s-]?term|final|semester|CIA|internal|university)\b/i.test(remainder);
      const isLunch = /\blunch\b/i.test(remainder);
      const isFree = /\b(free|no class)\b/i.test(remainder);
      const isBreak = /\bbreak\b/i.test(remainder);
      const kind = isExam ? 'exam' : isLunch ? 'lunch' : isFree ? 'free' : isBreak ? 'break' : 'class';
      const label = (remainder.match(/\b(?:lab(?:oratory)?|practical)\b/i) || [])[0] || '';
      let courseName = matched.course?.courseName || '';
      if (!courseName && code) {
        warnings.push(`Unknown course code "${code}"`);
      } else if (!courseName && !/\b(break|lunch|free|no class)\b/i.test(remainder)) {
        courseName = remainder
          .replace(/\b\d{2}[A-Z]{1,5}\d{2,3}\b/ig, '')
          .replace(/\b(lab(?:oratory)?|practical|exam(?:ination)?|mid[\s-]?term|final|semester)\b/ig, '')
          .replace(/\b(room|location|venue)\b\s*[:#-]?\s*/ig, '')
          .trim();
        warnings.push(courseName ? `Unrecognized course "${courseName}"` : 'Course is missing');
      }
      if (['break', 'lunch', 'free'].includes(kind)) courseName = '';
      if (matched.course && matched.byCode && remainder.toLowerCase().includes(matched.course.courseName.toLowerCase()) === false) {
        courseName = matched.course.courseName;
      }

      const locationMatch = remainder.match(/\b(?:room|location|venue)\s*[:#-]?\s*([^,;|]+)/i);
      const location = detectedLocation?.[1]?.trim()
        || locationMatch?.[1]?.trim()
        || remainder.match(/\b(?:LH|Lab|Room|Hall|Block)\s*[A-Z0-9-]+\b/i)?.[0]
        || '';
      if (!endTime && startTime && day && matched.course) {
        const configured = (options.knownPeriods || []).find((period) =>
          period.day === day && period.startTime === startTime
          && (!period.courseId || period.courseId === matched.courseId)
          && period.endTime);
        if (configured) endTime = configured.endTime;
        else if (Number.isInteger(options.periodMinutes) && options.periodMinutes > 0) {
          const total = Number(startTime.slice(0, 2)) * 60 + Number(startTime.slice(3)) + options.periodMinutes;
          if (total < 24 * 60) endTime = `${String(Math.floor(total / 60)).padStart(2, '0')}:${String(total % 60).padStart(2, '0')}`;
        }
      }
      if (!endTime) warnings.push('End time needs confirmation');
      if (startTime && endTime && endTime <= startTime) warnings.push('End time must be after start time');
      if (!matched.course && !code && courseName && !['break', 'lunch'].includes(kind)) warnings.push('Choose a course from the course list');

      entries.push({
        id: `parsed-${Date.now()}-${++sequence}`,
        day,
        date: currentDate || '',
        startTime,
        endTime,
        courseId: matched.courseId || '',
        courseName: courseName || matched.course?.courseName || '',
        courseCode: matched.course?.courseCode || code,
        kind,
        scheduleType: kind === 'exam' ? 'exam' : 'class',
        isLab,
        label,
        location,
        examType: isExam ? (remainder.match(/\b(mid[\s-]?term|final|semester|practical|oral|viva)\b/i)?.[0] || 'Exam') : '',
        notes: '',
        warnings,
        sourceLine: sourceLine.trim(),
      });
    });

    addDuplicateAndOverlapWarnings(entries);
    return { entries, issues };
  }

  function addDuplicateAndOverlapWarnings(entries) {
    entries.forEach((entry, index) => {
      for (let previousIndex = 0; previousIndex < index; previousIndex += 1) {
        const previous = entries[previousIndex];
        if (entry.day !== previous.day || entry.date !== previous.date || !entry.startTime || !previous.startTime) continue;
        if (entry.startTime === previous.startTime && entry.endTime === previous.endTime
          && entry.courseId === previous.courseId && entry.courseName === previous.courseName) {
          entry.warnings.push('Duplicate class');
          continue;
        }
        if (entry.endTime && previous.endTime
          && entry.startTime < previous.endTime && previous.startTime < entry.endTime) {
          entry.warnings.push(`Overlaps ${previous.startTime}–${previous.endTime}`);
        }
      }
    });
  }

  function validateEntry(entry) {
    const errors = [];
    const warnings = [...(Array.isArray(entry.warnings) ? entry.warnings : [])];
    if (!DAYS.includes(entry.day)) errors.push('Choose a weekday');
    if (!/^(?:[01]\d|2[0-3]):[0-5]\d$/.test(entry.startTime || '')) errors.push('Enter a valid start time');
    if (!/^(?:[01]\d|2[0-3]):[0-5]\d$/.test(entry.endTime || '')) errors.push('Enter an end time');
    if (entry.startTime && entry.endTime && entry.endTime <= entry.startTime) errors.push('End time must be after start time');
    if (entry.date && DAYS.includes(entry.day) && /^\d{4}-\d{2}-\d{2}$/.test(entry.date)) {
      const [year, month, day] = entry.date.split('-').map(Number);
      const date = new Date(year, month - 1, day);
      if (date.getFullYear() === year && date.getMonth() === month - 1 && date.getDate() === day
        && DAYS[(date.getDay() + 6) % 7] !== entry.day) {
        warnings.push('Weekday does not match the detected date');
      }
    }
    if (!['break', 'lunch', 'free'].includes(entry.kind) && !entry.courseName && !entry.courseId) errors.push('Choose or enter a course');
    return { errors: [...new Set(errors)], warnings: [...new Set(warnings)] };
  }

  function activeSchedule(records, date, scheduleType) {
    const day = String(date || '').slice(0, 10);
    return (records || [])
      .filter((record) => record.scheduleType === scheduleType
        && (!record.effectiveFrom || record.effectiveFrom <= day)
        && (!record.effectiveUntil || record.effectiveUntil >= day))
      .sort((a, b) => String(b.effectiveFrom || '').localeCompare(String(a.effectiveFrom || ''))
        || String(b.updatedAt || '').localeCompare(String(a.updatedAt || '')))[0] || null;
  }

  function getVisibleEntries(records, date) {
    const special = activeSchedule(records, date, 'special');
    const regular = activeSchedule(records, date, 'regular');
    const lab = activeSchedule(records, date, 'lab');
    return [
      ...(special || regular ? (special || regular).entries : []),
      ...(lab?.entries || []),
    ];
  }

  return {
    STORAGE_KEY,
    DAYS,
    TYPE_NAMES,
    normalizeCode,
    parseDate,
    parseClock,
    parseTimetableText,
    validateEntry,
    addDuplicateAndOverlapWarnings,
    activeSchedule,
    getVisibleEntries,
  };
});
