(() => {
  'use strict';

  const byId = (id) => document.getElementById(id);
  const dateKey = (date) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };
  const validDate = (value) => /^\d{4}-\d{2}-\d{2}$/.test(value)
    && !Number.isNaN(new Date(`${value}T00:00:00`).getTime());
  const format = (value, digits = 0) => Number(value).toLocaleString(undefined, {
    maximumFractionDigits: digits,
    minimumFractionDigits: 0
  });
  const formatMoney = (value) => `₹${Math.round(value).toLocaleString('en-IN')}`;

  function read(key, fallback, errors) {
    try {
      const raw = localStorage.getItem(key);
      return raw === null ? fallback : JSON.parse(raw);
    } catch (error) {
      console.error(`Could not read ${key}; existing data was left untouched.`, error);
      errors.push(key);
      return fallback;
    }
  }

  function historyRows(key, errors) {
    const saved = read(key, [], errors);
    if (!Array.isArray(saved) || !saved.every((row) => row && validDate(row.date))) {
      console.error(`Saved ${key} has an unexpected format; existing data was left untouched.`);
      errors.push(key);
      return [];
    }
    return saved;
  }

  function sessions(key, errors) {
    const saved = read(key, { sessions: [] }, errors);
    if (!saved || typeof saved !== 'object' || Array.isArray(saved)
        || !Array.isArray(saved.sessions)
        || !saved.sessions.every((row) => row && validDate(row.date))) {
      console.error(`Saved ${key} has an unexpected format; existing data was left untouched.`);
      errors.push(key);
      return [];
    }
    return saved.sessions;
  }

  function monthlySpend(errors) {
    const saved = read('blinkBudget', [], errors);
    if (!Array.isArray(saved) || !saved.every((item) => item && typeof item === 'object')) {
      console.error('Saved budget has an unexpected format; existing data was left untouched.');
      errors.push('blinkBudget');
      return null;
    }
    if (typeof budgetItems !== 'undefined' && typeof budgetMonthly === 'function') {
      return budgetItems.reduce((sum, item) => sum + Math.max(0, Number(budgetMonthly(item)) || 0), 0);
    }
    const comboActive = saved.some((item) => item.bundle === 'hk-vitals'
      && item.bundleRole === 'combo' && Number(item.usage) > 0);
    return saved.reduce((sum, item) => {
      if (comboActive && item.bundle === 'hk-vitals' && item.bundleRole !== 'combo') return sum;
      const price = Math.max(0, Number(item.price) || 0);
      const usage = Math.max(0, Number(item.usage) || 0);
      const days = Math.max(0, Number(item.days) || 30);
      if (item.packEveryDays) return sum + price * usage * days / Math.max(1, Number(item.packEveryDays));
      if (item.pack === 'monthly' || (String(item.unit || '').includes('month') && !item.packQty)) {
        return sum + price * usage;
      }
      return sum + price * usage * days / Math.max(1, Number(item.packQty) || 1);
    }, 0);
  }

  function average(values) {
    return values.length ? values.reduce((sum, value) => sum + value, 0) / values.length : null;
  }

  function chart(id, data, options) {
    const container = byId(id);
    if (!container) return;
    const maxValue = Math.max(0, ...data.map(options.value));
    container.dataset.range = String(data.length);
    container.style.setProperty('--wellness-days', String(data.length));
    container.replaceChildren();
    data.forEach((day) => {
      const column = document.createElement('div');
      column.className = 'wellnessBarDay';
      const value = options.value(day);
      const shown = options.label(value);
      const label = document.createElement('span');
      label.className = 'wellnessBarValue';
      label.textContent = shown;
      column.appendChild(label);
      const stack = document.createElement('div');
      stack.className = 'wellnessBarStack';
      options.bars(day).forEach((bar) => {
        const element = document.createElement('i');
        element.className = `wellnessBar ${bar.className}`;
        element.style.height = `${bar.value > 0 && maxValue > 0
          ? Math.max(3, bar.value / maxValue * 100) : 0}%`;
        stack.appendChild(element);
      });
      column.appendChild(stack);
      const parsed = new Date(`${day.date}T00:00:00`);
      const dayLabel = document.createElement('small');
      dayLabel.textContent = data.length === 7
        ? parsed.toLocaleDateString(undefined, { weekday: 'short' })
        : data.length > 90
          ? parsed.getDate() === 1 ? parsed.toLocaleDateString(undefined, { month: 'short' }) : ''
          : String(parsed.getDate());
      column.appendChild(dayLabel);
      column.title = `${parsed.toLocaleDateString()}: ${options.tooltip(day)}`;
      container.appendChild(column);
    });
  }

  function renderSleepLineChart(data, target) {
    const container = byId('sleepLineChart');
    const empty = byId('sleepLineChartEmpty');
    const total = byId('sleepLineChartTotal');
    const logged = data.filter((day) => Number.isFinite(day.sleepHours));
    container.replaceChildren();
    empty.style.display = logged.length ? 'none' : 'block';
    total.textContent = logged.length ? `${format(average(logged.map((day) => day.sleepHours)), 1)} hrs avg` : '—';
    if (!logged.length) return;

    const namespace = 'http://www.w3.org/2000/svg';
    const svg = document.createElementNS(namespace, 'svg');
    svg.setAttribute('viewBox', '0 0 320 140');
    svg.setAttribute('preserveAspectRatio', 'none');
    svg.setAttribute('aria-hidden', 'true');
    const left = 31;
    const right = 312;
    const top = 12;
    const bottom = 108;
    const yFor = (hours) => bottom - Math.max(0, Math.min(14, hours)) / 14 * (bottom - top);

    [0, 4, 8, 12].forEach((hours) => {
      const y = yFor(hours);
      const grid = document.createElementNS(namespace, 'line');
      grid.setAttribute('x1', String(left));
      grid.setAttribute('x2', String(right));
      grid.setAttribute('y1', String(y));
      grid.setAttribute('y2', String(y));
      grid.setAttribute('class', 'sleepLineGrid');
      svg.appendChild(grid);
      const label = document.createElementNS(namespace, 'text');
      label.setAttribute('x', '25');
      label.setAttribute('y', String(y + 3));
      label.setAttribute('text-anchor', 'end');
      label.setAttribute('class', 'sleepLineAxis');
      label.textContent = String(hours);
      svg.appendChild(label);
    });

    const targetLine = document.createElementNS(namespace, 'line');
    targetLine.setAttribute('x1', String(left));
    targetLine.setAttribute('x2', String(right));
    targetLine.setAttribute('y1', String(yFor(target)));
    targetLine.setAttribute('y2', String(yFor(target)));
    targetLine.setAttribute('class', 'sleepLineTarget');
    svg.appendChild(targetLine);

    let segment = [];
    const flushSegment = () => {
      if (!segment.length) return;
      const path = document.createElementNS(namespace, 'path');
      path.setAttribute('d', segment.map((point, index) =>
        `${index ? 'L' : 'M'}${point.x.toFixed(2)} ${point.y.toFixed(2)}`).join(' '));
      path.setAttribute('class', 'sleepLinePath');
      svg.appendChild(path);
      segment = [];
    };

    data.forEach((day, index) => {
      const x = data.length < 2 ? (left + right) / 2 : left + index / (data.length - 1) * (right - left);
      if (!Number.isFinite(day.sleepHours)) {
        flushSegment();
        return;
      }
      const y = yFor(day.sleepHours);
      segment.push({ x, y });
      const point = document.createElementNS(namespace, 'circle');
      point.setAttribute('cx', String(x));
      point.setAttribute('cy', String(y));
      point.setAttribute('r', data.length > 90 ? '1.6' : '3');
      point.setAttribute('class', 'sleepLinePoint');
      const title = document.createElementNS(namespace, 'title');
      title.textContent = `${new Date(`${day.date}T00:00:00`).toLocaleDateString()}: ${format(day.sleepHours, 1)} hours`;
      point.appendChild(title);
      svg.appendChild(point);

      const date = new Date(`${day.date}T00:00:00`);
      const showDate = data.length === 7 || index === 0 || index === data.length - 1
        || (data.length <= 30 && index % 5 === 0)
        || (data.length > 30 && date.getDate() === 1);
      if (showDate) {
        const label = document.createElementNS(namespace, 'text');
        label.setAttribute('x', String(x));
        label.setAttribute('y', '126');
        label.setAttribute('text-anchor', 'middle');
        label.setAttribute('class', 'sleepLineDate');
        label.textContent = data.length === 7
          ? date.toLocaleDateString(undefined, { weekday: 'short' })
          : date.toLocaleDateString(undefined, { month: 'short', day: 'numeric' });
        svg.appendChild(label);
      }
    });
    flushSegment();
    container.dataset.range = String(data.length);
    container.appendChild(svg);
  }

  function renderTrends(data) {
    const previous = data.slice(-14, -7);
    const current = data.slice(-7);
    const strongest = byId('wellnessStrongest');
    const weakest = byId('wellnessWeakest');
    if (previous.length !== 7) return;
    const measures = [
      { name: 'Workouts', get: (days) => days.reduce((sum, day) => sum + day.workouts, 0) },
      { name: 'Distance', get: (days) => days.reduce((sum, day) => sum + day.distanceMeters, 0) },
      { name: 'Protein', get: (days) => average(days.filter((day) => day.foodLogged).map((day) => day.protein)) },
      { name: 'Sleep', get: (days) => average(days.filter((day) => day.sleepHours !== null).map((day) => day.sleepHours)) },
      { name: 'Mind', get: (days) => days.reduce((sum, day) => sum + day.mindMinutes, 0) }
    ].map((measure) => {
      const before = measure.get(previous);
      const now = measure.get(current);
      if (before === null || now === null) return null;
      return {
        name: measure.name,
        before,
        now,
        change: before === 0 ? (now > 0 ? 100 : 0) : (now - before) / Math.abs(before) * 100
      };
    }).filter(Boolean);
    if (!measures.length) return;
    const up = measures.slice().sort((a, b) => b.change - a.change)[0];
    const down = measures.slice().sort((a, b) => a.change - b.change)[0];
    const detail = (item) => item.before === 0 && item.now > 0
      ? 'Started this week'
      : Math.abs(item.change) < 1 ? 'About the same as last week'
        : `${item.change > 0 ? '+' : ''}${Math.round(item.change)}% vs last week`;
    strongest.textContent = up.change > 0 ? up.name : 'Steady week';
    byId('wellnessStrongestDetail').textContent = detail(up);
    weakest.textContent = down.change < 0 ? down.name : 'No clear dip';
    byId('wellnessWeakestDetail').textContent = detail(down);
  }

  function render() {
    const range = [7, 30, 365].includes(Number(byId('wellnessRange')?.value))
      ? Number(byId('wellnessRange').value) : 7;
    const errors = [];
    const fuelRows = historyRows('blinkFuelDailyHistory', errors);
    const workoutRows = historyRows('blinkWorkoutDailyHistory', errors);
    const wellnessRows = historyRows('blinkWellnessLogs', errors);
    const gyms = sessions('blinkGymSessions', errors);
    const cardio = sessions('blinkCardioSessions', errors);
    const stepsSaved = read('blinkStepHistory', { days: {} }, errors);
    const mind = read('blinkMind', {}, errors);
    const sleepSaved = read('blinkSleepEstimates', { estimates: [] }, errors);
    const settings = read('blinkTrackerSettings', {}, errors);
    const budget = monthlySpend(errors);
    const estimates = Array.isArray(sleepSaved?.estimates) ? sleepSaved.estimates : [];
    const sleepByDate = new Map();
    estimates.forEach((entry) => {
      if (!entry || !validDate(entry.date) || !Number.isFinite(Number(entry.hours))
          || Number(entry.hours) < 3 || Number(entry.hours) > 14) return;
      const current = sleepByDate.get(entry.date);
      if (!current || Number(entry.wakeTime) > Number(current.wakeTime)) sleepByDate.set(entry.date, entry);
    });
    const fuelByDate = new Map(fuelRows.map((entry) => [entry.date, entry]));
    const workoutsByDate = new Map(workoutRows.map((entry) => [entry.date, entry]));
    const gymByDate = new Map();
    gyms.forEach((entry) => gymByDate.set(entry.date, (gymByDate.get(entry.date) || 0) + 1));
    const cardioByDate = new Map();
    cardio.forEach((entry) => {
      const current = cardioByDate.get(entry.date) || 0;
      cardioByDate.set(entry.date, current + Math.max(0, Number(entry.distanceMeters) || 0));
    });
    const wellnessByDate = new Map();
    wellnessRows.forEach((entry) => {
      const rows = wellnessByDate.get(entry.date) || [];
      rows.push(entry);
      wellnessByDate.set(entry.date, rows);
    });
    const configuredTarget = Number(settings?.sleepTargetHours);
    const sleepTarget = Number.isFinite(configuredTarget) && configuredTarget >= 4 && configuredTarget <= 14
      ? configuredTarget : 8;
    const today = new Date();
    const days = Array.from({ length: Math.max(14, range) }, (_, index) => {
      const date = new Date(today.getFullYear(), today.getMonth(), today.getDate() - Math.max(14, range) + 1 + index);
      const key = dateKey(date);
      const savedSleep = sleepByDate.get(key);
      const savedWellness = wellnessByDate.get(key) || [];
      const manualSleep = savedWellness.filter((entry) => entry.category === 'recovery'
        && Number.isFinite(entry.sleepHours)).reduce((sum, entry) => sum + entry.sleepHours, 0);
      const sleepHours = manualSleep > 0 ? manualSleep
        : savedSleep ? Number(savedSleep.hours) : null;
      const lateUses = Math.max(0, Number(savedSleep?.lateNightUseCount) || 0);
      const recoveryScore = sleepHours === null ? null
        : Math.max(0, Math.min(100, sleepHours / sleepTarget * 100) - Math.min(40, lateUses * 5));
      const fuel = fuelByDate.get(key);
      const loggedFood = savedWellness.filter((entry) => entry.category === 'food');
      const calories = fuel?.calories ?? loggedFood.reduce((sum, entry) => sum + (Number(entry.calories) || 0), 0);
      const protein = fuel?.proteinGrams ?? loggedFood.reduce((sum, entry) => sum + (Number(entry.proteinGrams) || 0), 0);
      const workoutLog = workoutsByDate.get(key);
      const workoutEntries = savedWellness.filter((entry) => entry.category === 'workout');
      const completed = Array.isArray(workoutLog?.exerciseIds) ? workoutLog.exerciseIds.length : 0;
      const workoutCount = workoutEntries.length + completed + (gymByDate.get(key) || 0);
      const mindMinutes = Math.max(0, Number(mind?.days?.[key]) || 0);
      const mindSessions = Math.max(0, Number(mind?.sessionsByDay?.[key]) || (mindMinutes > 0 ? 1 : 0));
      const stepCount = Math.max(0, Number(stepsSaved?.days?.[key]) || 0);
      return {
        date: key,
        calories,
        protein,
        foodLogged: Boolean(fuel) || loggedFood.length > 0,
        workouts: workoutCount,
        distanceMeters: cardioByDate.get(key) || 0,
        steps: stepCount,
        sleepHours,
        lateUses,
        recoveryScore,
        mindMinutes,
        mindSessions
      };
    });
    const selected = days.slice(-range);
    const foodDays = selected.filter((day) => day.foodLogged);
    const sleepDays = selected.filter((day) => day.sleepHours !== null);
    const totalCalories = foodDays.reduce((sum, day) => sum + day.calories, 0);
    const totalProtein = foodDays.reduce((sum, day) => sum + day.protein, 0);
    const totalWorkouts = selected.reduce((sum, day) => sum + day.workouts, 0);
    const totalGym = selected.reduce((sum, day) => sum + (gymByDate.get(day.date) || 0), 0);
    const totalDistance = selected.reduce((sum, day) => sum + day.distanceMeters, 0);
    const totalSteps = selected.reduce((sum, day) => sum + day.steps, 0);
    const totalMind = selected.reduce((sum, day) => sum + day.mindMinutes, 0);
    const totalMindSessions = selected.reduce((sum, day) => sum + day.mindSessions, 0);
    const scoreDays = selected.filter((day) => day.recoveryScore !== null);
    const averageScore = average(scoreDays.map((day) => day.recoveryScore));
    const phoneDays = selected.filter((day) => sleepByDate.has(day.date)
      && Number.isFinite(Number(sleepByDate.get(day.date)?.lateNightUseCount)));
    const phoneUses = phoneDays.reduce((sum, day) => sum + day.lateUses, 0);
    const spend = budget === null ? null : budget / 30 * range;

    byId('analysisCalories').textContent = foodDays.length ? `${format(totalCalories / foodDays.length)} kcal` : '—';
    byId('analysisCaloriesDetail').textContent = `${foodDays.length} logged food days`;
    byId('analysisProtein').textContent = foodDays.length ? `${format(totalProtein / foodDays.length, 1)} g` : '—';
    byId('analysisProteinDetail').textContent = 'average per logged food day';
    byId('weeklyWorkoutCount').textContent = format(totalWorkouts);
    byId('weeklyWorkoutDetail').textContent = `${totalGym} gym visits · ${format(selected.reduce((sum, day) => sum + day.workouts, 0))} total activities`;
    byId('analysisDistance').innerHTML = `${format(totalDistance / 1000, 2)} <small>km</small>`;
    byId('analysisActivityDetail').textContent = `${format(totalSteps)} steps`;
    byId('weeklySleep').innerHTML = `${sleepDays.length ? format(average(sleepDays.map((day) => day.sleepHours)), 1) : '—'} <small>hrs</small>`;
    byId('analysisSleepDetail').textContent = `${sleepDays.length} logged nights · ${format(sleepTarget, 1)} h target`;
    byId('analysisMindSessions').textContent = format(totalMindSessions);
    byId('analysisMindDetail').textContent = `${format(totalMind)} min mindfulness`;
    byId('analysisSpending').textContent = spend === null ? '—' : formatMoney(spend);
    byId('analysisSpendingDetail').textContent = spend === null
      ? 'Budget plan unavailable' : `estimate from monthly plan · ${formatMoney(budget / 30)}/day`;
    byId('analysisNightUse').textContent = phoneDays.length ? `${format(phoneUses)} uses` : '—';
    byId('analysisRecoveryScore').textContent = averageScore === null
      ? 'Android sleep estimates required'
      : `${format(averageScore)} / 100 · 5 points per night use (max 40 deducted)`;
    byId('wellnessRangeSummary').textContent = `${foodDays.length} food days · ${totalWorkouts} workouts/activities · ${format(totalDistance / 1000, 2)} km · ${sleepDays.length} sleep nights`;
    byId('foodChartTotal').textContent = `${format(totalCalories)} kcal`;
    byId('proteinChartTotal').textContent = `${format(totalProtein, 1)} g`;
    byId('workoutChartTotal').textContent = `${format(totalWorkouts)} activities`;
    byId('activityChartTotal').textContent = `${format(totalDistance / 1000, 2)} km`;
    byId('recoveryChartTotal').textContent = averageScore === null ? '—' : `${format(averageScore)} / 100 avg`;
    byId('spendingChartTotal').textContent = spend === null ? '—' : `${formatMoney(spend)} est.`;

    chart('proteinActivityChart', selected, {
      value: (day) => day.protein,
      label: (value) => value ? `${format(value, 1)}g` : '—',
      bars: (day) => [{ value: day.protein, className: 'proteinBar' }],
      tooltip: (day) => `${format(day.protein, 1)} g protein`
    });
    chart('activityDistanceChart', selected, {
      value: (day) => Math.max(day.distanceMeters / 1000, day.steps / 1000),
      label: (value) => value ? format(value, 1) : '—',
      bars: (day) => [
        { value: day.distanceMeters / 1000, className: 'distanceBar' },
        { value: day.steps / 1000, className: 'stepsBar' }
      ],
      tooltip: (day) => `${format(day.distanceMeters / 1000, 2)} km GPS distance · ${format(day.steps)} steps`
    });
    chart('recoveryActivityChart', selected, {
      value: (day) => Math.max(day.recoveryScore || 0, day.lateUses * 5),
      label: (value) => value ? format(value) : '—',
      bars: (day) => [
        { value: day.recoveryScore || 0, className: 'recoveryBar' },
        { value: day.lateUses * 5, className: 'sleepBar' }
      ],
      tooltip: (day) => `${day.recoveryScore === null ? 'No sleep score' : `${format(day.recoveryScore)} recovery score`} · ${day.lateUses} detected night phone uses`
    });
    chart('spendingActivityChart', selected, {
      value: () => budget === null ? 0 : budget / 30,
      label: (value) => value ? formatMoney(value) : '—',
      bars: () => [{ value: budget === null ? 0 : budget / 30, className: 'spendingBar' }],
      tooltip: () => budget === null ? 'Budget plan unavailable' : `${formatMoney(budget / 30)} estimated daily spending from the monthly plan`
    });
    renderSleepLineChart(selected, sleepTarget);
    byId('proteinChartEmpty').style.display = foodDays.length ? 'none' : 'block';
    byId('activityChartEmpty').style.display = totalDistance || totalSteps ? 'none' : 'block';
    byId('recoveryChartEmpty').style.display = scoreDays.length || phoneUses ? 'none' : 'block';
    byId('spendingChartEmpty').style.display = spend !== null && spend > 0 ? 'none' : 'block';
    renderTrends(days);

    const status = byId('wellnessAnalysisStatus');
    if (errors.length) {
      status.textContent = `Some history could not be read: ${[...new Set(errors)].join(', ')}. Other data is still shown.`;
      status.classList.add('error');
    } else {
      status.textContent = 'Spending is estimated from the saved monthly budget plan, not recorded purchases. Night-use recovery deductions use Android Usage Access estimates. History remains stored locally.';
      status.classList.remove('error');
    }
  }

  byId('wellnessRange')?.addEventListener('change', render);
  window.BlinkAppState?.subscribe((_state, key) => {
    if (key === null || [
      'blinkBudget', 'blinkCal', 'blinkCardioSessions', 'blinkFoods',
      'blinkFuelDailyHistory', 'blinkGymSessions', 'blinkMind',
      'blinkSleepEstimates', 'blinkStepHistory', 'blinkWellnessLogs',
      'blinkWorkoutDailyHistory', 'blinkWorkoutLogs'
    ].includes(key)) render();
  });
  window.addEventListener('focus', render);
  window.addEventListener('pageshow', render);
  window.setInterval(render, 60 * 60 * 1000);
  render();
})();
