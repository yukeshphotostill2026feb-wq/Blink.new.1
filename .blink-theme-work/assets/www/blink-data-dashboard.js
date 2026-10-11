(() => {
  'use strict';

  const DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const USAGE_KEY = 'blinkAppUsageHistory';
  const NIGHT_KEY = 'blinkNightUsageHistory';
  const GYM_KEY = 'blinkGymSessions';
  const CARDIO_KEY = 'blinkCardioSessions';
  const SLEEP_KEY = 'blinkSleepEstimates';
  const WORKOUT_KEY = 'blinkWorkoutDailyHistory';
  const ROUTE_KEY = 'blinkEditableRouteByDay';
  const SPLIT_KEY = 'blinkWorkoutFocusByDay';
  const byId = (id) => document.getElementById(id);
  const todayKey = (date = new Date()) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };
  const read = (key, fallback) => window.BlinkAppState.read(key, fallback);
  const write = (key, value) => window.BlinkAppState.write(key, value);
  const escapeHtml = (value) => String(value ?? '').replace(/[&<>"']/g, (character) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  })[character]);
  const duration = (milliseconds) => {
    const minutes = Math.floor(Math.max(0, Number(milliseconds) || 0) / 60000);
    return minutes >= 60 ? `${Math.floor(minutes / 60)}h ${String(minutes % 60).padStart(2, '0')}m` : `${minutes}m`;
  };
  const displayDate = (value) => new Date(`${value}T00:00:00`).toLocaleDateString(undefined, {
    weekday: 'short', month: 'short', day: 'numeric'
  });

  function object(key) {
    const value = read(key, {});
    return value && typeof value === 'object' && !Array.isArray(value) ? value : {};
  }

  function recordArray(key, member) {
    const value = object(key)[member];
    return Array.isArray(value) ? value : [];
  }

  function daysForRange() {
    const selected = byId('blinkDataRange')?.value || '30';
    const keys = new Set([todayKey()]);
    [GYM_KEY, CARDIO_KEY, SLEEP_KEY].forEach((key) => {
      const member = key === SLEEP_KEY ? 'estimates' : 'sessions';
      recordArray(key, member).forEach((row) => row?.date && keys.add(row.date));
    });
    [WORKOUT_KEY].forEach((key) => {
      const rows = read(key, []);
      if (Array.isArray(rows)) rows.forEach((row) => row?.date && keys.add(row.date));
    });
    [USAGE_KEY, NIGHT_KEY].forEach((key) => {
      Object.keys(object(key).days || {}).forEach((date) => keys.add(date));
    });
    const sorted = [...keys].filter((date) => /^\d{4}-\d{2}-\d{2}$/.test(date)).sort();
    if (selected === 'all') return sorted;
    const count = Number(selected) || 30;
    const end = new Date();
    return Array.from({ length: count }, (_, index) => {
      const date = new Date(end.getFullYear(), end.getMonth(), end.getDate() - count + 1 + index);
      return todayKey(date);
    });
  }

  function activityByDate() {
    const dates = daysForRange();
    const workouts = new Map();
    const gym = new Map();
    const cardio = new Map();
    const recovery = new Map();
    const usageHistory = object(USAGE_KEY).days || {};
    const nightHistory = object(NIGHT_KEY).days || {};
    const workoutRows = read(WORKOUT_KEY, []);
    (Array.isArray(workoutRows) ? workoutRows : []).forEach((row) => {
      if (row?.date) workouts.set(row.date, (row.exerciseIds?.length || 0) + (workouts.get(row.date) || 0));
    });
    recordArray(GYM_KEY, 'sessions').forEach((row) => {
      if (row?.date) gym.set(row.date, (gym.get(row.date) || 0) + 1);
    });
    recordArray(CARDIO_KEY, 'sessions').forEach((row) => {
      if (!row?.date) return;
      const current = cardio.get(row.date) || { meters: 0, sessions: 0 };
      current.meters += Math.max(0, Number(row.distanceMeters) || 0);
      current.sessions++;
      cardio.set(row.date, current);
    });
    recordArray(SLEEP_KEY, 'estimates').forEach((row) => {
      if (!row?.date || !Number.isFinite(Number(row.recoveryPercent))) return;
      const current = recovery.get(row.date);
      if (!current || Number(row.windowEndTime || row.wakeTime || 0)
          >= Number(current.windowEndTime || current.wakeTime || 0)) recovery.set(row.date, row);
    });
    return dates.map((date) => ({
      date,
      workouts: workouts.get(date) || 0,
      gym: gym.get(date) || 0,
      cardio: cardio.get(date) || { meters: 0, sessions: 0 },
      recovery: recovery.get(date) || null,
      usage: usageHistory[date] || null,
      night: nightHistory[date] || null
    }));
  }

  function barMarkup(rows, value, formatter, color) {
    const max = Math.max(1, ...rows.map((row) => Number(value(row)) || 0));
    return `<div class="blinkDataBars">${rows.map((row) => {
      const amount = Math.max(0, Number(value(row)) || 0);
      const height = amount ? Math.max(4, amount / max * 100) : 2;
      return `<div class="blinkDataBar" title="${escapeHtml(displayDate(row.date))}: ${escapeHtml(formatter(amount, row))}">
        <strong>${escapeHtml(formatter(amount, row))}</strong><i style="--bar-height:${height}%;--bar-color:${color}"></i>
        <small>${escapeHtml(new Date(`${row.date}T00:00:00`).toLocaleDateString(undefined, { weekday: 'narrow' }))}</small>
      </div>`;
    }).join('')}</div>`;
  }

  function renderData() {
    const panel = byId('blinkDataContent');
    if (!panel) return;
    const rows = activityByDate();
    const gymTotal = rows.reduce((sum, row) => sum + row.gym, 0);
    const cardioTotal = rows.reduce((sum, row) => sum + row.cardio.meters, 0);
    const cardioSessions = rows.reduce((sum, row) => sum + row.cardio.sessions, 0);
    const recoveryRows = rows.filter((row) => row.recovery);
    const recoveryAverage = recoveryRows.length
      ? Math.round(recoveryRows.reduce((sum, row) => sum + Number(row.recovery.recoveryPercent || 0), 0) / recoveryRows.length) : null;
    const usageRows = rows.filter((row) => row.usage?.apps?.length);
    const appTotals = new Map();
    usageRows.forEach((row) => row.usage.apps.forEach((app) => {
      appTotals.set(app.name, (appTotals.get(app.name) || 0) + Number(app.milliseconds || 0));
    }));
    const topApps = [...appTotals.entries()].sort((first, second) => second[1] - first[1]).slice(0, 8);
    const dayCount = Math.max(1, usageRows.length);
    const rowsToShow = rows.slice(-Math.min(28, rows.length));
    panel.innerHTML = `<div class="blinkDataSummary">
      <article><span>GYM PRESENCES</span><strong>${gymTotal}</strong><small>saved visits in range</small></article>
      <article><span>GPS CARDIO</span><strong>${(cardioTotal / 1000).toFixed(1)} <small>km</small></strong><small>${cardioSessions} completed sessions</small></article>
      <article><span>RECOVERY</span><strong>${recoveryAverage === null ? '—' : `${recoveryAverage}%`}</strong><small>${recoveryRows.length} saved estimates</small></article>
      <article><span>PHONE USAGE</span><strong>${usageRows.length ? duration(usageRows.reduce((sum, row) => sum + Number(row.usage.totalMilliseconds || 0), 0) / dayCount) : '—'}</strong><small>average per sampled day</small></article>
    </div>
    <div class="blinkDataGrid">
      <article class="blinkDataPanel"><div class="blinkDataPanelHead"><div><span>TRAINING</span><h3>Gym presences by day</h3></div><b>${gymTotal} visits</b></div>
        ${barMarkup(rows, (row) => row.gym, (value) => String(value), '#ff5d4f')}</article>
      <article class="blinkDataPanel"><div class="blinkDataPanelHead"><div><span>WORKOUTS</span><h3>Exercise completions</h3></div><b>${rows.reduce((sum, row) => sum + row.workouts, 0)} completions</b></div>
        ${barMarkup(rows, (row) => row.workouts, (value) => String(value), '#b1a0e8')}</article>
      <article class="blinkDataPanel"><div class="blinkDataPanelHead"><div><span>GPS</span><h3>Cardio distance</h3></div><b>${(cardioTotal / 1000).toFixed(1)} km</b></div>
        ${barMarkup(rows, (row) => row.cardio.meters, (value) => `${(value / 1000).toFixed(1)}`, '#77c8d0')}</article>
      <article class="blinkDataPanel"><div class="blinkDataPanelHead"><div><span>RECOVERY</span><h3>Daily estimate</h3></div><b>${recoveryAverage === null ? 'No data' : `${recoveryAverage}% avg`}</b></div>
        ${barMarkup(rows, (row) => row.recovery ? Number(row.recovery.recoveryPercent) : 0, (value, row) => row.recovery ? `${Math.round(value)}%` : '—', '#77d5b6')}</article>
      <article class="blinkDataPanel"><div class="blinkDataPanelHead"><div><span>SCREEN TIME</span><h3>Daily phone use</h3></div><b>${usageRows.length} sampled days</b></div>
        ${barMarkup(rows, (row) => row.usage?.totalMilliseconds || 0, (value) => value ? duration(value) : '—', '#a8aeb8')}</article>
    </div>
    <article class="blinkDataPanel blinkAppsPanel"><div class="blinkDataPanelHead"><div><span>APP USAGE</span><h3>Most-used apps</h3></div><b>Overuse flag: 2h/day</b></div>
      ${topApps.length ? `<div class="blinkAppRanking">${topApps.map(([name, milliseconds]) => `<div class="blinkAppRank"><span>${escapeHtml(name)}</span><i><b style="width:${Math.min(100, milliseconds / Math.max(1, topApps[0][1]) * 100)}%"></b></i><strong>${duration(milliseconds / dayCount)}${milliseconds / dayCount >= 7200000 ? ' · HIGH' : ''}</strong></div>`).join('')}</div>` : '<p class="blinkDataEmpty">App usage appears after Android Usage Access is granted and BLINK has sampled a day.</p>'}
      <button type="button" class="blinkDataAction" data-action="sync-usage">Sync app usage</button>
      <div class="blinkDataRows">${rowsToShow.slice().reverse().map((row) => `<div><span>${escapeHtml(displayDate(row.date))}</span><strong>${row.usage ? duration(row.usage.totalMilliseconds) : 'No app sample'}</strong><small>${escapeHtml(row.usage?.topApp || '—')}</small></div>`).join('')}</div>
    </article>
    <details class="blinkDataPanel blinkRecoveryDetails"><summary><span><small>OVERNIGHT RECOVERY</small><strong>11:00 PM–6:30 AM phone-use detail</strong></span><i>+</i></summary>
      <p class="blinkDataEmpty">Recovery scores come from Android Usage Access. Per-app overnight detail is accumulated from app-usage snapshots while BLINK is active; unsampled periods are not inferred.</p>
      <div class="blinkDataRows">${recoveryRows.slice().reverse().map((row) => {
        const night = row.night;
        const topNight = night?.apps ? Object.entries(night.apps).sort((a, b) => b[1] - a[1]).slice(0, 3) : [];
        return `<div><span>${escapeHtml(displayDate(row.date))} · ${Math.round(Number(row.recovery.recoveryPercent) || 0)}%</span><strong>Phone ${duration(row.recovery.nightPhoneUseMs)} · free ${duration(row.recovery.phoneFreeMs)}</strong><small>${topNight.length ? topNight.map(([name, ms]) => `${escapeHtml(name)} ${duration(ms)}`).join(' · ') : 'No per-app night sample recorded'}</small></div>`;
      }).join('') || '<div><span>No recovery estimates saved yet.</span></div>'}</div>
    </details>
    <details class="blinkDataPanel blinkDailyHistory"><summary><span><small>BY DATE</small><strong>Saved activity history</strong></span><i>+</i></summary>
      <div class="blinkDataRows">${rows.slice().reverse().map((row) => `<div><span>${escapeHtml(displayDate(row.date))}</span><strong>Gym ${row.gym} · Cardio ${(row.cardio.meters / 1000).toFixed(2)} km · Workout ${row.workouts}</strong><small>${row.recovery ? `Recovery ${Math.round(Number(row.recovery.recoveryPercent))}%` : 'Recovery —'} · Phone ${row.usage ? duration(row.usage.totalMilliseconds) : '—'}</small></div>`).join('')}</div>
    </details>`;
  }

  function selectedDay(selectId) {
    return byId(selectId)?.value || DAYS[(new Date().getDay() + 6) % 7];
  }

  function savedPlans() {
    const value = read('blinkWorkoutsByDay', {});
    return value && typeof value === 'object' && !Array.isArray(value) ? value : {};
  }

  function currentExerciseNames(day) {
    const plan = savedPlans()[day];
    if (Array.isArray(plan)) return plan.map((exercise) => exercise?.n || '').filter(Boolean);
    if (day === 'Sunday') return [];
    const priorDay = byId('gymDayTitle')?.textContent;
    if (typeof window.setGymDay === 'function') window.setGymDay(day);
    const names = [...document.querySelectorAll('#todayWorkout .exerciseName')].map((node) => node.textContent.trim());
    if (priorDay && DAYS.includes(priorDay) && typeof window.setGymDay === 'function') window.setGymDay(priorDay);
    return names;
  }

  function renderSplitEditor() {
    const day = selectedDay('blinkSplitDay');
    const existing = savedPlans()[day];
    const names = currentExerciseNames(day);
    const focusByDay = read(SPLIT_KEY, {});
    const focus = focusByDay?.[day] || '';
    if (byId('blinkSplitExercises')) byId('blinkSplitExercises').value = names.join('\n');
    if (byId('blinkSplitFocus')) byId('blinkSplitFocus').value = focus;
    if (byId('blinkSplitStatus')) byId('blinkSplitStatus').textContent = existing ? 'Saved custom split' : 'Using current default split';
  }

  function renderRouteEditor() {
    const day = selectedDay('blinkRouteDay');
    const routes = read(ROUTE_KEY, {});
    const route = Array.isArray(routes?.[day]) ? routes[day] : [];
    if (byId('blinkRouteEntries')) byId('blinkRouteEntries').value = route
      .map((item) => `${item.time} | ${item.place} | ${item.activity}`).join('\n');
    if (byId('blinkRouteStatus')) byId('blinkRouteStatus').textContent = route.length ? `${route.length} editable stops saved for ${day}.` : `No custom route yet for ${day}.`;
    const preview = byId('blinkRoutePreview');
    if (preview) preview.innerHTML = route.map((item) => `<div><b>${escapeHtml(item.time)}</b><span>${escapeHtml(item.place)}</span><small>${escapeHtml(item.activity)}</small></div>`).join('');
  }

  function installEditors() {
    const gym = byId('gym');
    if (gym && !byId('blinkSplitEditor')) {
      const editor = document.createElement('details');
      editor.id = 'blinkSplitEditor';
      editor.className = 'blinkEditorPanel';
      editor.innerHTML = `<summary><span><small>TRAINING PLAN</small><strong>Edit weekly gym split</strong></span><i>+</i></summary>
        <div class="blinkEditorBody"><label>Training day<select id="blinkSplitDay">${DAYS.slice(0, 6).map((day) => `<option>${day}</option>`).join('')}</select></label>
        <label>Focus<input id="blinkSplitFocus" maxlength="80" placeholder="Strength · conditioning · recovery"></label>
        <label>Exercises, one per line<textarea id="blinkSplitExercises" rows="5" placeholder="Searchable exercise names"></textarea></label>
        <div class="blinkEditorFoot"><span id="blinkSplitStatus" role="status"></span><button type="button" data-action="save-split">Save split</button></div>
        <p>Exercise names must match the exercise library. Saving updates that weekday’s workout plan.</p></div>`;
      gym.insertBefore(editor, gym.querySelector('.gymTabs') || gym.firstChild);
    }
    const routePanel = byId('roadmap');
    if (routePanel && !byId('blinkRouteEditor')) {
      const editor = document.createElement('details');
      editor.id = 'blinkRouteEditor';
      editor.className = 'blinkEditorPanel';
      editor.innerHTML = `<summary><span><small>WEEKLY ROUTE</small><strong>Edit day route</strong></span><i>+</i></summary>
        <div class="blinkEditorBody"><label>Route day<select id="blinkRouteDay">${DAYS.map((day) => `<option>${day}</option>`).join('')}</select></label>
        <label>Stops, one per line: time | place | activity<textarea id="blinkRouteEntries" rows="6" placeholder="7:00 AM | Home | Morning routine&#10;9:00 AM | Campus | Study session"></textarea></label>
        <div class="blinkEditorFoot"><span id="blinkRouteStatus" role="status"></span><button type="button" data-action="save-route">Save day route</button></div>
        <div id="blinkRoutePreview" class="blinkRoutePreview"></div></div>`;
      const anchor = routePanel.querySelector('.routeHero');
      if (anchor) anchor.insertAdjacentElement('afterend', editor);
      else routePanel.appendChild(editor);
    }
    const activeDay = DAYS[Math.min(5, (new Date().getDay() + 6) % 7)];
    if (byId('blinkSplitDay')) byId('blinkSplitDay').value = activeDay;
    if (byId('blinkRouteDay')) byId('blinkRouteDay').value = activeDay;
    renderSplitEditor();
    renderRouteEditor();
  }

  function saveSplit() {
    const day = selectedDay('blinkSplitDay');
    const names = (byId('blinkSplitExercises')?.value || '').split(/\n|,/).map((name) => name.trim()).filter(Boolean);
    const exercises = [];
    for (const name of names) {
      const exercise = typeof window.findExercise === 'function' ? window.findExercise(name) : null;
      if (!exercise) {
        byId('blinkSplitStatus').textContent = `Not found in library: ${name}`;
        return;
      }
      exercises.push(exercise);
    }
    const plans = savedPlans();
    plans[day] = exercises;
    const focusByDay = read(SPLIT_KEY, {});
    focusByDay[day] = byId('blinkSplitFocus')?.value.trim() || '';
    try {
      write('blinkWorkoutsByDay', plans);
      write(SPLIT_KEY, focusByDay);
      const currentDay = byId('gymDayTitle')?.textContent;
      if (currentDay === day && typeof window.setGymDay === 'function') window.setGymDay(day);
      byId('blinkSplitStatus').textContent = `${day} split saved (${exercises.length} exercises).`;
    } catch (error) {
      byId('blinkSplitStatus').textContent = `Could not save split: ${error.message || 'storage unavailable'}`;
    }
  }

  function saveRoute() {
    const day = selectedDay('blinkRouteDay');
    const lines = (byId('blinkRouteEntries')?.value || '').split('\n').map((line) => line.trim()).filter(Boolean);
    const route = [];
    for (const line of lines) {
      const parts = line.split('|').map((part) => part.trim());
      if (parts.length !== 3 || parts.some((part) => !part)) {
        byId('blinkRouteStatus').textContent = `Use time | place | activity format: ${line}`;
        return;
      }
      route.push({ time: parts[0], place: parts[1], activity: parts[2] });
    }
    const routes = read(ROUTE_KEY, {});
    routes[day] = route;
    try {
      write(ROUTE_KEY, routes);
      byId('blinkRouteStatus').textContent = `${route.length} stops saved for ${day}.`;
      renderRouteEditor();
      const preview = byId('blinkRoutePreview');
      if (preview) preview.innerHTML = route.map((item) => `<div><b>${escapeHtml(item.time)}</b><span>${escapeHtml(item.place)}</span><small>${escapeHtml(item.activity)}</small></div>`).join('');
    } catch (error) {
      byId('blinkRouteStatus').textContent = `Could not save route: ${error.message || 'storage unavailable'}`;
    }
  }

  function installDataPanel() {
    const topNav = document.querySelector('.topNav');
    if (!topNav || byId('blinkDataNav')) return;
    const nav = document.createElement('button');
    nav.id = 'blinkDataNav';
    nav.type = 'button';
    nav.setAttribute('aria-label', 'Data and analysis');
    nav.setAttribute('onclick', "tab('data',this)");
    nav.innerHTML = '<span>▥</span>Data';
    const mindButton = [...topNav.querySelectorAll('button')].find((button) => button.getAttribute('onclick')?.includes("'mind'"));
    topNav.insertBefore(nav, mindButton || null);
    nav.addEventListener('click', renderData);
    const panel = document.createElement('section');
    panel.id = 'data';
    panel.className = 'panel';
    panel.innerHTML = `<div class="section"><h2>Data</h2><span class="link">SAVED BY DATE</span></div>
      <div class="blinkDataToolbar"><label>History<select id="blinkDataRange"><option value="7">7 days</option><option value="30" selected>30 days</option><option value="90">90 days</option><option value="all">All saved days</option></select></label>
      <button type="button" data-action="sync-usage">Sync app use</button></div><div id="blinkDataContent" aria-live="polite"></div>`;
    const settings = byId('settings');
    if (settings) settings.insertAdjacentElement('beforebegin', panel);
    else document.body.appendChild(panel);
    byId('blinkDataRange').addEventListener('change', renderData);
    renderData();
  }

  function applyFocusOverride() {
    const title = byId('gymDayTitle');
    const label = byId('gymFocus');
    if (!title || !label) return;
    const custom = read(SPLIT_KEY, {})[title.textContent];
    const replacement = custom ? `${custom} · Editable weekly split` : '';
    if (replacement && label.textContent !== replacement) label.textContent = replacement;
  }

  function installFoodKeyboardFlow() {
    const viewport = window.visualViewport;
    if (!viewport) return;
    let maximumHeight = Math.max(window.innerHeight, viewport.height);
    const update = () => {
      maximumHeight = Math.max(maximumHeight, window.innerHeight, viewport.height);
      const keyboardOpen = maximumHeight - viewport.height > 140
        && Boolean(document.activeElement?.closest('#diet'));
      document.body.classList.toggle('blinkKeyboardOpen', keyboardOpen);
      if (keyboardOpen && document.activeElement?.closest('#diet')) {
        document.activeElement.scrollIntoView({ block: 'nearest', inline: 'nearest', behavior: 'smooth' });
      }
    };
    viewport.addEventListener('resize', update);
    viewport.addEventListener('scroll', update);
    window.addEventListener('orientationchange', () => {
      maximumHeight = Math.max(window.innerHeight, viewport.height);
      update();
    });
    document.addEventListener('focusin', (event) => {
      if (event.target.closest('#diet') && /INPUT|TEXTAREA|SELECT/.test(event.target.tagName)) {
        window.setTimeout(update, 120);
      }
    });
    document.addEventListener('focusout', () => window.setTimeout(update, 180));
    update();
  }

  document.addEventListener('click', (event) => {
    const action = event.target.closest('[data-action]')?.dataset.action;
    if (action === 'save-split') saveSplit();
    if (action === 'save-route') saveRoute();
    if (action === 'sync-usage') window.BlinkTodayTracking?.refreshAppUsage();
  });
  document.addEventListener('change', (event) => {
    if (event.target.id === 'blinkSplitDay') renderSplitEditor();
    if (event.target.id === 'blinkRouteDay') renderRouteEditor();
  });
  window.addEventListener('blink:usage-updated', renderData);
  window.addEventListener('blink:native-update', renderData);
  window.addEventListener('storage', (event) => {
    if ([USAGE_KEY, NIGHT_KEY, GYM_KEY, CARDIO_KEY, SLEEP_KEY, WORKOUT_KEY].includes(event.key)) renderData();
  });
  window.addEventListener('blink:tab-change', (event) => {
    if (event.detail?.id === 'data') renderData();
  });

  installDataPanel();
  installEditors();
  installFoodKeyboardFlow();
  const focusTarget = byId('gymFocus');
  if (focusTarget) new MutationObserver(applyFocusOverride).observe(focusTarget, { childList: true, characterData: true, subtree: true });
  applyFocusOverride();
})();
