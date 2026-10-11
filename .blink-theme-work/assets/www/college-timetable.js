(() => {
  'use strict';

  const data = window.BLINK_COLLEGE_TIMETABLE;
  if (!data) {
    console.error('College timetable data is unavailable.');
    return;
  }

  const $ = (id) => document.getElementById(id);
  const dayNames = data.days;
  const shortDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const attendanceKey = 'blinkCollegeAttendance';
  const reminderSettingsKey = 'blinkCollegeReminderSettings';
  let selectedDay = dayNames[new Date().getDay() === 0 ? 6 : new Date().getDay() - 1];
  let selectedCourseId = '';
  let attendanceRecords = [];
  let attendanceError = '';
  let reminderSettings = { enabled: false, examEnabled: false, examOneHourEnabled: false };
  let reminderError = '';
  let selectedView = 'today';

  function escapeHtml(value) {
    return String(value ?? '').replace(/[&<>"']/g, (char) => ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#39;',
    })[char]);
  }

  function dateKey(date) {
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
  }

  function dateFromKey(key) {
    const match = String(key).match(/^(\d{4})-(\d{2})-(\d{2})$/);
    if (!match) return null;
    const date = new Date(Number(match[1]), Number(match[2]) - 1, Number(match[3]));
    return dateKey(date) === key ? date : null;
  }

  function minutesOfDay(time) {
    if (!time) return null;
    const [hours, minutes] = time.split(':').map(Number);
    return hours * 60 + minutes;
  }

  function formatTime(time) {
    if (!time) return 'Full day';
    const [hours, minutes] = time.split(':').map(Number);
    return new Date(2000, 0, 1, hours, minutes).toLocaleTimeString(undefined, {
      hour: 'numeric',
      minute: '2-digit',
    });
  }

  function formatInterval(item) {
    return item.allDay ? 'Full day' : `${formatTime(item.startTime)} – ${formatTime(item.endTime)}`;
  }

  function scheduleForDay(day, date = '') {
    const sourceSchedule = date && window.BlinkCollegeScheduleManager?.entriesForDate
      ? window.BlinkCollegeScheduleManager.entriesForDate(date)
      : data.schedule;
    return sourceSchedule
      .filter((item) => item.day === day && (!item.date || (date && item.date === date)))
      .map((item) => ({
        ...item,
        course: item.courseId ? data.courses[item.courseId] : item.courseName
          ? { courseName: item.courseName, courseCode: item.courseCode || '', faculty: '', type: '' }
          : null,
      }))
      .sort((a, b) => (minutesOfDay(a.startTime) ?? 0) - (minutesOfDay(b.startTime) ?? 0));
  }

  function classSessions(items) {
    return items.filter((item) => item.course && (item.kind === 'class' || item.kind === 'project'));
  }

  function statusAt(item, now) {
    if (item.allDay || !item.startTime || !item.endTime) return 'upcoming';
    const current = now.getHours() * 60 + now.getMinutes();
    const start = minutesOfDay(item.startTime);
    const end = minutesOfDay(item.endTime);
    if (current >= end) return 'completed';
    if (current >= start) return 'current';
    return 'upcoming';
  }

  function itemTitle(item) {
    if (item.kind === 'break') return item.label || 'Break';
    if (item.kind === 'lunch') return 'Lunch';
    if (item.kind === 'free') return item.label || 'No class';
    if (item.kind === 'project') return item.label || 'Project Progress Review';
    const name = item.course?.courseName || item.label || '';
    return item.isLab && name && !/\blab\b/i.test(name) ? `${name} Lab` : name;
  }

  function itemDisplayCode(item) {
    if (!item.course) return '';
    return `${item.course.courseCode}${item.isLab ? ' LAB' : ''}`;
  }

  function currentSummary(items, day, now) {
    const actualToday = day === dayNames[(now.getDay() + 6) % 7];
    if (day === 'Sunday') {
      return {
        title: 'No classes — Complete Rest Day',
        detail: 'Sunday is the weekly rest day for the college schedule.',
        state: 'rest',
      };
    }
    if (!items.length) {
      return { title: 'No class right now', detail: 'No timetable activities are listed for this day.', state: 'empty' };
    }
    if (!actualToday) {
      const classes = classSessions(items);
      const first = classes[0];
      return {
        title: first ? `${classes.length} scheduled ${classes.length === 1 ? 'class' : 'classes'}` : 'Project review day',
        detail: first ? `First: ${itemTitle(first)} · ${formatTime(first.startTime)}` : 'Project progress review.',
        state: 'scheduled',
      };
    }
    if (day === 'Saturday') {
      const project = items.find((item) => item.courseId === 'BT511');
      return {
        title: project?.course?.courseName || 'Project review day',
        detail: project ? `${project.course.courseCode} · ${project.label} · Full day` : 'Project Progress Review · Full day',
        state: 'project',
      };
    }

    const current = items.find((item) => item.startTime && statusAt(item, now) === 'current');
    const nextActivity = items.find((item) => item.startTime && statusAt(item, now) === 'upcoming');
    const nextClass = classSessions(items).find((item) => item.startTime && statusAt(item, now) === 'upcoming');
    const completedCount = classSessions(items).filter((item) => statusAt(item, now) === 'completed').length;
    const remainingCount = classSessions(items).filter((item) => statusAt(item, now) !== 'completed').length;
    let title;
    let detail;
    let state = 'no-class';

    if (current?.course && (current.kind === 'class' || current.kind === 'project')) {
      title = `Current class · ${itemTitle(current)}`;
      detail = `${itemDisplayCode(current)} · ${formatInterval(current)}${current.course ? ` · ${current.course.faculty}` : ''}`;
      state = 'current';
    } else {
      title = 'No class right now';
      if (current?.kind === 'lunch') detail = 'Lunch break is in progress.';
      else if (current?.kind === 'break') detail = `${current.label || 'Break'} is in progress.`;
      else if (current?.kind === 'free') detail = 'No class is scheduled in this period.';
      else detail = 'No class is currently in session.';
      if (nextActivity) {
        detail += ` Next: ${itemTitle(nextActivity)} at ${formatTime(nextActivity.startTime)}.`;
      } else {
        detail += ' Classes finished for today.';
      }
    }

    const nextText = nextClass
      ? `Next class: ${itemTitle(nextClass)}${nextClass.isLab ? ' · LAB' : ''} at ${formatTime(nextClass.startTime)}.`
      : 'No remaining classes today.';
    return {
      title,
      detail: `${detail} ${nextText} ${completedCount} completed · ${remainingCount} remaining.`,
      state,
      current,
      nextClass,
      completedCount,
      remainingCount,
    };
  }

  function daySelectorMarkup(container) {
    if (!container) return;
    const todayName = dayNames[(new Date().getDay() + 6) % 7];
    container.innerHTML = dayNames.map((day, index) => {
      const isToday = day === todayName;
      return `<button type="button" data-tt-day="${day}" class="${day === selectedDay ? 'selected' : ''}${isToday ? ' today' : ''}" aria-pressed="${day === selectedDay}">${shortDays[index]}${isToday ? '<small>Today</small>' : ''}</button>`;
    }).join('');
    container.querySelectorAll('[data-tt-day]').forEach((button) => {
      button.addEventListener('click', () => {
        selectedDay = button.dataset.ttDay;
        renderAll();
      });
    });
  }

  function eventMarkup(item, options = {}) {
    const { now = new Date(), live = false, nextClassId = '', attendance = false, date = '' } = options;
    const status = live ? statusAt(item, now) : 'upcoming';
    const kind = item.kind || 'class';
    const classes = ['tt-event', status, kind];
    if (item.isLab) classes.push('lab');
    const stateText = item.allDay ? 'FULL DAY'
      : kind === 'break' ? `BREAK${live ? ` · ${status === 'current' ? 'NOW' : status === 'completed' ? 'DONE' : 'UP NEXT'}` : ''}`
        : kind === 'lunch' ? `LUNCH${live ? ` · ${status === 'current' ? 'NOW' : status === 'completed' ? 'DONE' : 'UP NEXT'}` : ''}`
          : kind === 'free' ? `NO CLASS${live ? ` · ${status === 'current' ? 'NOW' : status === 'completed' ? 'DONE' : 'UP NEXT'}` : ''}`
            : status.toUpperCase();
    const label = item.label && kind !== 'project' ? `<div class="tt-event-label">${escapeHtml(item.label)}</div>` : '';
    const name = item.course ? item.course.courseName : itemTitle(item);
    const code = itemDisplayCode(item);
    const classAction = item.course ? ` data-open-course="${escapeHtml(item.courseId)}" role="button" tabindex="0"` : '';
    const meta = item.course
      ? `<div class="tt-event-meta"><span>${escapeHtml(item.course.faculty)}</span>${item.location ? `<span>Location: ${escapeHtml(item.location)}</span>` : ''}${item.isLab ? `<span>${durationText(item)}</span>` : ''}</div>`
      : '';
    const lab = item.isLab ? '<span class="tt-lab-badge">LAB</span>' : '';
    const next = item.id === nextClassId ? '<span class="tt-lab-badge">NEXT</span>' : '';
    const attendanceControl = attendance
      ? `<label class="tt-attendance-row"><span>${escapeHtml(itemTitle(item))} · ${escapeHtml(formatInterval(item))}</span><select data-attendance-session="${escapeHtml(item.id)}" data-attendance-date="${escapeHtml(date)}" aria-label="Attendance status for ${escapeHtml(formatInterval(item))}"><option value="">Not marked</option><option value="present">Present</option><option value="absent">Absent</option><option value="excused">Excused</option></select></label>`
      : '';
    if (attendance) return attendanceControl;
    return `<article class="${classes.join(' ')}" data-session-id="${escapeHtml(item.id)}"${classAction}><div class="tt-event-time"><span>${escapeHtml(formatInterval(item))}</span>${!item.allDay ? `<small>${durationText(item)}</small>` : ''}</div><div class="tt-event-main"><div class="tt-event-top">${code ? `<span class="tt-code">${escapeHtml(code)}</span>` : ''}${lab}${next}<span class="tt-status-badge">${stateText}</span></div><div class="tt-event-name">${escapeHtml(name)}</div>${label}${meta}</div></article>`;
  }

  function durationText(item) {
    const start = minutesOfDay(item.startTime);
    const end = minutesOfDay(item.endTime);
    if (start === null || end === null) return 'Full day';
    const minutes = end - start;
    const hours = Math.floor(minutes / 60);
    const rest = minutes % 60;
    return hours ? `${hours}h${rest ? ` ${rest}m` : ''}` : `${minutes} min`;
  }

  function timelineMarkup(items, day, live, now) {
    if (day === 'Sunday') {
      return '<div class="tt-empty"><strong>No classes — Complete Rest Day</strong>Enjoy your Sunday.</div>';
    }
    if (!items.length) return '<div class="tt-empty">No scheduled activities for this day.</div>';
    const currentInfo = currentSummary(items, day, now);
    const nextClassId = live ? currentInfo.nextClass?.id || '' : '';
    const marker = live && day !== 'Saturday'
      ? `<div class="tt-now-marker" aria-label="Current local time"><span>NOW · ${escapeHtml(formatTime(`${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`))}</span><i></i></div>`
      : '';
    const contents = items.map((item) => eventMarkup(item, { now, live, nextClassId })).join('');
    return `${marker}${contents}`;
  }

  function renderToday() {
    const now = new Date();
    const today = dayNames[(now.getDay() + 6) % 7];
    const items = scheduleForDay(today, dateKey(now));
    const summary = currentSummary(items, today, now);
    const heading = $('ttTodayHeading');
    const currentPanel = $('ttCurrentPanel');
    const timeline = $('ttTodayTimeline');
    if (heading) heading.textContent = `Today's timeline · ${today}`;
    if (currentPanel) {
      const currentItem = summary.current;
      const progress = currentItem?.startTime
        ? Math.max(0, Math.min(100, ((now.getHours() * 60 + now.getMinutes() - minutesOfDay(currentItem.startTime)) / (minutesOfDay(currentItem.endTime) - minutesOfDay(currentItem.startTime))) * 100))
        : 0;
      currentPanel.className = `tt-current-panel ${summary.state}`;
      currentPanel.innerHTML = `<span class="tt-current-label">${summary.state === 'current' ? 'HAPPENING NOW' : summary.state === 'project' ? 'PROJECT DAY' : summary.state === 'rest' ? 'REST DAY' : 'TODAY AT A GLANCE'}</span><strong>${escapeHtml(summary.title)}</strong><p>${escapeHtml(summary.detail)}</p>${summary.state === 'current' ? `<div class="tt-progress" aria-label="Class progress"><i style="width:${progress}%"></i></div>` : ''}`;
    }
    if (timeline) {
      timeline.classList.toggle('tt-timeline', true);
      timeline.dataset.live = String(today !== 'Saturday' && today !== 'Sunday');
      timeline.innerHTML = timelineMarkup(items, today, true, now);
    }
    const todaySummary = $('collegeTodaySummary');
    const todayStatus = $('collegeTodayStatus');
    if (todaySummary && todayStatus) {
      todaySummary.textContent = summary.title;
      todayStatus.textContent = summary.detail;
    }
    if (today !== 'Saturday' && today !== 'Sunday') positionNowMarker(items, now, 'ttTodayTimeline');
    bindCourseCards(timeline);
  }

  function positionNowMarker(items, now, timelineId) {
    const timeline = $(timelineId);
    const marker = timeline?.querySelector('.tt-now-marker');
    if (!timeline || !marker) return;
    const nowMinutes = now.getHours() * 60 + now.getMinutes() + now.getSeconds() / 60;
    const target = items.find((item) => item.startTime && nowMinutes >= minutesOfDay(item.startTime) && nowMinutes < minutesOfDay(item.endTime))
      || items.find((item) => item.startTime && minutesOfDay(item.startTime) > nowMinutes)
      || items[items.length - 1];
    const targetElement = target ? timeline.querySelector(`[data-session-id="${target.id}"]`) : null;
    const markerLabel = marker.querySelector('span');
    if (markerLabel) markerLabel.textContent = `NOW · ${formatTime(`${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`)}`;
    if (!targetElement) {
      marker.style.top = '0px';
      return;
    }
    const start = minutesOfDay(target.startTime) ?? nowMinutes;
    const end = minutesOfDay(target.endTime) ?? start;
    const fraction = end > start ? Math.max(0, Math.min(1, (nowMinutes - start) / (end - start))) : 0;
    marker.style.top = `${Math.max(0, targetElement.offsetTop + targetElement.offsetHeight * fraction - 9)}px`;
  }

  function renderWeek() {
    daySelectorMarkup($('ttWeekDaySelector'));
    const timeline = $('ttWeekTimeline');
    if (!timeline) return;
    const now = new Date();
    const isLive = selectedDay === dayNames[(now.getDay() + 6) % 7];
    const items = scheduleForDay(selectedDay);
    const summary = currentSummary(items, selectedDay, now);
    timeline.innerHTML = `<div class="tt-section-day"><strong>${escapeHtml(selectedDay)}</strong><span>${escapeHtml(summary.title)}</span></div>${timelineMarkup(items, selectedDay, isLive, now)}`;
    timeline.dataset.live = String(isLive && selectedDay !== 'Saturday' && selectedDay !== 'Sunday');
    if (isLive && selectedDay !== 'Saturday' && selectedDay !== 'Sunday') positionNowMarker(items, now, 'ttWeekTimeline');
    bindCourseCards(timeline);
  }

  function bindCourseCards(container) {
    container?.querySelectorAll('[data-open-course]').forEach((card) => {
      const open = () => openCourse(card.dataset.openCourse);
      card.addEventListener('click', open);
      card.addEventListener('keydown', (event) => {
        if (event.key === 'Enter' || event.key === ' ') {
          event.preventDefault();
          open();
        }
      });
    });
  }

  function weeklySessions(courseId) {
    return data.schedule
      .filter((item) => !item.date && item.courseId === courseId && (item.kind === 'class' || item.kind === 'project'))
      .sort((a, b) => dayNames.indexOf(a.day) - dayNames.indexOf(b.day) || (minutesOfDay(a.startTime) ?? 0) - (minutesOfDay(b.startTime) ?? 0));
  }

  function renderCourseList() {
    const list = $('ttCourseList');
    if (!list) return;
    list.innerHTML = Object.entries(data.courses).map(([id, course]) => {
      const sessions = weeklySessions(id);
      const minutes = sessions.reduce((sum, item) => sum + ((minutesOfDay(item.endTime) ?? 0) - (minutesOfDay(item.startTime) ?? 0)), 0);
      const duration = minutes ? `${Math.floor(minutes / 60)}h${minutes % 60 ? ` ${minutes % 60}m` : ''} scheduled weekly` : 'Full-day project review';
      return `<button type="button" class="tt-course-item" data-course-id="${escapeHtml(id)}"><span><strong>${escapeHtml(course.courseCode)}${course.isLab ? ' · LAB' : ''} — ${escapeHtml(course.courseName)}</strong><small>${escapeHtml(course.type)} · ${sessions.length} scheduled ${sessions.length === 1 ? 'session' : 'sessions'} · ${duration}</small></span><span>DETAILS →</span></button>`;
    }).join('');
    list.querySelectorAll('[data-course-id]').forEach((button) => button.addEventListener('click', () => openCourse(button.dataset.courseId)));
    renderCourseDetail();
  }

  function readAttendance() {
    try {
      const saved = localStorage.getItem(attendanceKey);
      if (!saved) return [];
      const value = JSON.parse(saved);
      if (!Array.isArray(value)) throw new Error('Saved attendance must be an array.');
      return value.filter((record) => record && typeof record === 'object'
        && typeof record.courseId === 'string'
        && typeof record.sessionId === 'string'
        && typeof record.date === 'string'
        && ['present', 'absent', 'excused'].includes(record.status));
    } catch (error) {
      attendanceError = 'Could not load attendance records from this device.';
      console.error('Could not load college attendance', error);
      return [];
    }
  }

  function readReminderSettings() {
    try {
      const saved = localStorage.getItem(reminderSettingsKey);
      if (saved) {
        const value = JSON.parse(saved);
        if (!value || typeof value.enabled !== 'boolean') throw new Error('Saved reminder setting is invalid.');
        reminderSettings = {
          enabled: value.enabled,
          examEnabled: value.examEnabled === true,
          examOneHourEnabled: value.examOneHourEnabled === true,
        };
      }
    } catch (error) {
      reminderError = 'Could not load class reminder settings.';
      console.error('Could not load college reminder settings', error);
    }
  }

  function attendanceCount(courseId) {
    const records = attendanceRecords.filter((record) => record.courseId === courseId);
    const present = records.filter((record) => record.status === 'present').length;
    const absent = records.filter((record) => record.status === 'absent').length;
    const excused = records.filter((record) => record.status === 'excused').length;
    const denominator = present + absent;
    return {
      present,
      absent,
      excused,
      percentage: denominator ? `${Math.round((present / denominator) * 100)}%` : '—',
      marked: records.length,
    };
  }

  function renderCourseDetail() {
    const detail = $('ttCourseDetail');
    if (!detail) return;
    const course = data.courses[selectedCourseId];
    if (!course) {
      detail.hidden = true;
      return;
    }
    detail.hidden = false;
    const sessions = weeklySessions(selectedCourseId);
    const weeklyMinutes = sessions.reduce((sum, item) => sum + ((minutesOfDay(item.endTime) ?? 0) - (minutesOfDay(item.startTime) ?? 0)), 0);
    const weeklyDuration = weeklyMinutes ? `${Math.floor(weeklyMinutes / 60)}h${weeklyMinutes % 60 ? ` ${weeklyMinutes % 60}m` : ''}` : 'Full-day';
    const currentDate = dateKey(new Date());
    const count = attendanceCount(selectedCourseId);
    const attendanceDate = $('ttAttendanceDate')?.value || currentDate;
    const dateObj = dateFromKey(attendanceDate);
    const dateSessions = dateObj && dayNames[(dateObj.getDay() + 6) % 7] !== 'Sunday'
      ? sessions.filter((item) => item.day === dayNames[(dateObj.getDay() + 6) % 7])
      : [];
    const schedules = sessions.length
      ? sessions.map((item) => `<div class="tt-detail-session"><span><strong>${escapeHtml(item.day)} · ${escapeHtml(formatInterval(item))}</strong>${item.label ? ` · ${escapeHtml(item.label)}` : ''}${item.isLab ? ' · LAB' : ''}${item.location ? ` · ${escapeHtml(item.location)}` : ''}</span><span>${escapeHtml(durationText(item))}</span></div>`).join('')
      : '<div class="tt-placeholder">No timed sessions listed; scheduled as a full-day project review.</div>';
    const attendanceRows = dateSessions.length
      ? dateSessions.map((item) => eventMarkup(item, { attendance: true, date: attendanceDate })).join('')
      : '<div class="tt-placeholder">No session for this course is scheduled on the selected date.</div>';
    const recentAttendance = attendanceRecords.filter((record) => record.courseId === selectedCourseId)
      .sort((a, b) => b.date.localeCompare(a.date))
      .slice(0, 5)
      .map((record) => `<div class="tt-detail-session"><span><strong>${escapeHtml(record.date)}</strong></span><span>${escapeHtml(record.status[0].toUpperCase() + record.status.slice(1))}</span></div>`)
      .join('');

    detail.innerHTML = `<button type="button" class="tt-detail-back" id="ttCourseBack">‹ All courses</button><h2>${escapeHtml(course.courseName)}</h2><div class="tt-detail-code">${escapeHtml(course.courseCode)}${course.isLab ? ' · LAB' : ''}</div><div class="tt-detail-grid"><div class="tt-detail-field"><span>Credits</span><strong>${course.credits}</strong></div><div class="tt-detail-field"><span>Hours allotted</span><strong>${course.hours} hours</strong></div><div class="tt-detail-field"><span>Classification</span><strong>${escapeHtml(course.type)}</strong></div><div class="tt-detail-field"><span>Faculty</span><strong>${escapeHtml(course.faculty)}</strong></div><div class="tt-detail-field"><span>Weekly scheduled periods</span><strong>${sessions.length} scheduled ${sessions.length === 1 ? 'session' : 'sessions'} · ${escapeHtml(weeklyDuration)}</strong></div><div class="tt-detail-field"><span>Attendance</span><strong>${count.marked ? `${count.present} present · ${count.absent} absent · ${count.excused} excused · ${count.percentage} of present/absent` : 'No attendance marked'}</strong></div></div><h3>Weekly schedule</h3><div class="tt-schedule-list">${schedules}</div><h3>Attendance · mark a scheduled occurrence</h3><p class="tt-attendance-summary">Attendance is only calculated from entries you mark. Excused sessions are excluded from the present/absent percentage.</p><input id="ttAttendanceDate" class="tt-attendance-date" type="date" value="${escapeHtml(attendanceDate)}" aria-label="Attendance date"><div class="tt-attendance-list">${attendanceRows}</div>${attendanceError ? `<p class="tt-attendance-error">${escapeHtml(attendanceError)}</p>` : ''}${recentAttendance ? `<h3>Recent marked attendance</h3><div class="tt-schedule-list">${recentAttendance}</div>` : ''}<h3>Notes</h3><div class="tt-placeholder">No notes yet.</div><h3>Assignments</h3><div class="tt-placeholder">No assignments recorded yet.</div>`;
    $('ttCourseBack')?.addEventListener('click', () => {
      detail.hidden = true;
      $('ttCourseList')?.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
    });
    $('ttAttendanceDate')?.addEventListener('change', renderCourseDetail);
    detail.querySelectorAll('[data-attendance-session]').forEach((select) => {
      const existing = attendanceRecords.find((record) => record.sessionId === select.dataset.attendanceSession && record.date === select.dataset.attendanceDate);
      select.value = existing?.status || '';
      select.addEventListener('change', () => markAttendance(select));
    });
  }

  function markAttendance(select) {
    const courseId = selectedCourseId;
    const sessionId = select.dataset.attendanceSession;
    const date = select.dataset.attendanceDate;
    const status = select.value;
    const updatedRecords = attendanceRecords.filter((record) => !(record.sessionId === sessionId && record.date === date));
    if (status) updatedRecords.push({ courseId, sessionId, date, status, updatedAt: new Date().toISOString() });
    try {
      localStorage.setItem(attendanceKey, JSON.stringify(updatedRecords));
      attendanceRecords = updatedRecords;
      attendanceError = '';
      renderCourseDetail();
    } catch (error) {
      console.error('Could not save college attendance', error);
      attendanceError = 'Could not save attendance on this device. Check available storage and try again.';
      renderCourseDetail();
    }
  }

  function openCourse(courseId) {
    if (!data.courses[courseId]) return;
    selectedCourseId = courseId;
    showView('courses');
    renderCourseList();
    $('ttCourseDetail')?.scrollIntoView({ block: 'start', behavior: 'smooth' });
  }

  function showView(view) {
    if (!['today', 'week', 'courses', 'manager'].includes(view)) return;
    selectedView = view;
    document.querySelectorAll('[data-tt-view]').forEach((button) => {
      const active = button.dataset.ttView === view;
      button.classList.toggle('active', active);
      button.setAttribute('aria-selected', String(active));
    });
    $('ttViewToday').hidden = view !== 'today';
    $('ttViewWeek').hidden = view !== 'week';
    $('ttViewCourses').hidden = view !== 'courses';
    $('ttViewManager').hidden = view !== 'manager';
    if (view === 'today') renderToday();
    if (view === 'week') renderWeek();
    if (view === 'courses') renderCourseList();
  }

  function renderAll() {
    daySelectorMarkup($('ttWeekDaySelector'));
    renderToday();
    renderWeek();
    renderCourseList();
  }

  function renderCalendarPreview(key) {
    const container = $('collegeCalendarPreview');
    if (!container) return;
    const date = dateFromKey(key);
    if (!date) {
      container.textContent = 'Could not determine the selected calendar date.';
      return;
    }
    const day = dayNames[(date.getDay() + 6) % 7];
    if (day === 'Sunday') {
      container.innerHTML = '<div class="tt-calendar-item"><span>No classes — Complete Rest Day</span></div>';
      return;
    }
    const items = classSessions(scheduleForDay(day, key));
    if (!items.length) {
      container.innerHTML = '<div class="tt-calendar-item"><span>No college activities listed.</span></div>';
      return;
    }
    const preview = items.slice(0, 3).map((item) => `<div class="tt-calendar-item"><time>${item.allDay ? 'FULL DAY' : escapeHtml(formatTime(item.startTime))}</time><span>${escapeHtml(itemTitle(item))}${item.isLab ? ' · LAB' : ''}${item.label && item.kind !== 'project' ? ` · ${escapeHtml(item.label)}` : ''}</span></div>`).join('');
    const extra = items.length > 3 ? `<div class="tt-calendar-more">+${items.length - 3} more scheduled activities</div>` : '';
    container.innerHTML = `${preview}${extra}<div class="tt-calendar-more">${escapeHtml(day)} · recurring academic schedule · not added to personal events</div>`;
  }

  function setReminderPreference(enabled) {
    reminderError = '';
    requestReminderPermission(enabled);
    reminderSettings = { ...reminderSettings, enabled };
    saveReminderSettings();
  }

  function setExamReminderPreference(key, enabled) {
    reminderError = '';
    if (key === 'examOneHourEnabled' && enabled && !reminderSettings.examEnabled) {
      reminderSettings.examEnabled = true;
    }
    reminderSettings = { ...reminderSettings, [key]: enabled };
    if (!reminderSettings.examEnabled) reminderSettings.examOneHourEnabled = false;
    requestReminderPermission(enabled);
    saveReminderSettings();
  }

  function requestReminderPermission(enabled) {
    if (enabled && window.BlinkNative?.requestClassReminderPermission) {
      try {
        window.BlinkNative.requestClassReminderPermission();
      } catch (error) {
        console.error('Could not request native class reminder permission', error);
        reminderError = 'Could not request Android notification permission.';
      }
    } else if (enabled && !window.BlinkNative?.showNotification && 'Notification' in window && Notification.permission === 'default') {
      try {
        const asked = localStorage.getItem('blinkClassReminderPermissionRequested') === 'true';
        if (!asked) {
          localStorage.setItem('blinkClassReminderPermissionRequested', 'true');
          Notification.requestPermission()
            .then(renderReminderStatus)
            .catch((error) => {
              console.error('Could not request class reminder permission', error);
              reminderError = 'Notification permission could not be requested.';
              renderReminderStatus();
            });
        }
      } catch (error) {
        console.error('Could not store class reminder permission state', error);
        reminderError = 'Could not save notification permission settings on this device.';
      }
    }
  }

  function saveReminderSettings() {
    try {
      localStorage.setItem(reminderSettingsKey, JSON.stringify(reminderSettings));
    } catch (error) {
      console.error('Could not save class reminder setting', error);
      reminderError = 'Could not save class reminder settings on this device.';
    }
    renderReminderStatus();
  }

  function renderReminderStatus() {
    const note = document.querySelector('.tt-reminder-note');
    if (!note) return;
    const classControl = $('ttReminderEnabled');
    const examControl = $('ttExamReminderEnabled');
    const examHourControl = $('ttExamHourReminderEnabled');
    if (classControl) classControl.checked = reminderSettings.enabled;
    if (examControl) examControl.checked = reminderSettings.examEnabled;
    if (examHourControl) {
      examHourControl.checked = reminderSettings.examOneHourEnabled;
      examHourControl.disabled = !reminderSettings.examEnabled;
    }
    const anyEnabled = reminderSettings.enabled || reminderSettings.examEnabled;
    const missingNativePermission = anyEnabled
      && window.BlinkNative?.hasNotificationPermission
      && !window.BlinkNative.hasNotificationPermission();
    const browserNotificationsUnavailable = anyEnabled
      && !window.BlinkNative?.showNotification
      && !('Notification' in window);
    const browserPermissionMissing = anyEnabled
      && !window.BlinkNative?.showNotification
      && 'Notification' in window
      && Notification.permission !== 'granted';
    note.textContent = reminderError
      || (missingNativePermission
        ? 'Allow notifications for BLINK in Android settings to receive class reminders. Android permission is requested only once.'
        : browserNotificationsUnavailable
          ? 'This browser does not support notifications, so class reminders cannot be delivered.'
          : browserPermissionMissing
              ? 'Allow browser notifications for BLINK to receive class reminders.'
          : `Class reminders ${reminderSettings.enabled ? 'on' : 'off'} · 15 minutes before class. Exam reminders ${reminderSettings.examEnabled ? 'on' : 'off'} · 1 day before${reminderSettings.examOneHourEnabled ? ' and 1 hour before' : ''}. Checked locally while BLINK is open.`);
  }

  function deliverReminder(item, minutes) {
    const title = `${item.course.courseName} in ${minutes} minutes`;
    const message = `${item.course.courseCode}${item.isLab ? ' · LAB' : ''}${item.label ? ` · ${item.label}` : ''} · ${formatTime(item.startTime)}${item.location ? ` · ${item.location}` : ''}`;
    try {
      if (window.BlinkNative?.showNotification) {
        window.BlinkNative.showNotification(title, message, '•_•');
        return;
      }
      if ('Notification' in window && Notification.permission === 'granted') {
        new Notification(title, { body: message });
        return;
      }
      reminderError = 'Class reminder is due, but notifications are not enabled on this device.';
    } catch (error) {
      console.error('Could not deliver class reminder', error);
      reminderError = 'Could not deliver the class reminder.';
    }
    renderReminderStatus();
  }

  function checkClassReminders() {
    if ((!reminderSettings.enabled && !reminderSettings.examEnabled) || document.visibilityState === 'hidden') return;
    const now = new Date();
    const day = dayNames[(now.getDay() + 6) % 7];
    const todayItems = classSessions(scheduleForDay(day));
    todayItems.forEach((item) => {
      if (!reminderSettings.enabled || !item.startTime) return;
      const lead = 15;
      const [startHour, startMinute] = item.startTime.split(':').map(Number);
      const classStart = new Date(now.getFullYear(), now.getMonth(), now.getDate(), startHour, startMinute);
      const startsInMs = classStart.getTime() - now.getTime();
      if (startsInMs < 0 || startsInMs > lead * 60 * 1000) return;
      const firedKey = `blinkCollegeReminderFired:${dateKey(now)}:${item.id}`;
      try {
        if (localStorage.getItem(firedKey)) return;
        localStorage.setItem(firedKey, 'true');
      } catch (error) {
        console.error('Could not track class reminder delivery', error);
        reminderError = 'Could not track class reminder delivery on this device.';
        renderReminderStatus();
        return;
      }
      deliverReminder(item, Math.ceil(startsInMs / 60000));
    });
    if (reminderSettings.examEnabled || reminderSettings.examOneHourEnabled) {
      try {
        const records = JSON.parse(localStorage.getItem('blinkCollegeSchedules') || '[]');
        const today = dateKey(now);
        records.filter((record) => record.scheduleType === 'exam' && Array.isArray(record.entries))
          .flatMap((record) => record.entries.map((exam) => ({ ...exam, schedule: record })))
          .filter((exam) => exam.date && exam.startTime
            && (!exam.schedule.effectiveFrom || exam.schedule.effectiveFrom <= exam.date)
            && (!exam.schedule.effectiveUntil || exam.schedule.effectiveUntil >= exam.date))
          .forEach((exam) => {
            const [year, month, date] = exam.date.split('-').map(Number);
            const [hour, minute] = exam.startTime.split(':').map(Number);
            const start = new Date(year, month - 1, date, hour, minute);
            const minutesUntil = (start.getTime() - now.getTime()) / 60000;
            const leads = [];
            if (reminderSettings.examEnabled) leads.push(1440);
            if (reminderSettings.examOneHourEnabled) leads.push(60);
            leads.forEach((lead) => {
              if (minutesUntil <= 0 || minutesUntil > lead) return;
              const firedKey = `blinkCollegeExamReminderFired:${exam.date}:${exam.startTime}:${exam.courseCode || exam.courseName}:${lead}`;
              if (localStorage.getItem(firedKey)) return;
              localStorage.setItem(firedKey, 'true');
              const title = `${exam.courseName || exam.courseCode || 'Exam'} in ${Math.ceil(minutesUntil / 60)} hour${Math.ceil(minutesUntil / 60) === 1 ? '' : 's'}`;
              const message = `${exam.courseCode || ''}${exam.examType ? ` · ${exam.examType}` : ''}${exam.location ? ` · ${exam.location}` : ''} · ${exam.date} ${formatTime(exam.startTime)}`;
              try {
                if (window.BlinkNative?.showNotification) window.BlinkNative.showNotification(title, message, '•_•');
                else if ('Notification' in window && Notification.permission === 'granted') new Notification(title, { body: message });
                else reminderError = 'An exam reminder is due, but notifications are not enabled on this device.';
              } catch (error) {
                console.error('Could not deliver exam reminder', error);
                reminderError = 'Could not deliver the exam reminder.';
              }
            });
          });
      } catch (error) {
        console.error('Could not check exam reminder schedule', error);
        reminderError = 'Could not check saved exam reminders.';
      }
    }
    renderReminderStatus();
  }

  window.openCollegeTimetable = (view = 'today') => {
    if (typeof window.tab === 'function') window.tab('college-timetable');
    document.querySelectorAll('.nav button').forEach((button) => button.classList.remove('active'));
    document.querySelector('.nav button[onclick*="\'schedule\'"]')?.classList.add('active');
    showView(view);
  };
  window.blinkCollegeTimetable = {
    renderCalendarPreview,
    refreshFromSchedules: () => {
      renderAll();
      renderCalendarPreview(dateKey(new Date()));
    },
  };

  document.querySelectorAll('[data-tt-view]').forEach((button) => {
    button.addEventListener('click', () => showView(button.dataset.ttView));
  });
  $('ttReminderEnabled')?.addEventListener('change', (event) => setReminderPreference(event.target.checked));
  $('ttExamReminderEnabled')?.addEventListener('change', (event) => setExamReminderPreference('examEnabled', event.target.checked));
  $('ttExamHourReminderEnabled')?.addEventListener('change', (event) => setExamReminderPreference('examOneHourEnabled', event.target.checked));
  attendanceRecords = readAttendance();
  readReminderSettings();
  renderReminderStatus();
  renderCalendarPreview(dateKey(new Date()));
  renderAll();
  checkClassReminders();
  setInterval(() => {
    if (document.visibilityState === 'hidden') return;
    const activePanel = document.querySelector('.panel.active')?.id;
    if (activePanel === 'college-timetable') {
      if (selectedView === 'today') renderToday();
      if (selectedView === 'week') renderWeek();
    } else if (activePanel === 'home') {
      renderToday();
    }
    checkClassReminders();
  }, 15000);
  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') {
      const activePanel = document.querySelector('.panel.active')?.id;
      if (activePanel === 'college-timetable' && selectedView === 'today') renderToday();
      if (activePanel === 'college-timetable' && selectedView === 'week') renderWeek();
      if (activePanel === 'home') renderToday();
      checkClassReminders();
    }
  });
  window.addEventListener('blink:native-update', renderReminderStatus);
})();
