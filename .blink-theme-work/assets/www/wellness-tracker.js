(() => {
  'use strict';

  const STORAGE_KEY = 'blinkWellnessLogs';
  const categories = {
    food: 'Food & fuel',
    workout: 'Workout',
    recovery: 'Recovery'
  };
  const byId = (id) => document.getElementById(id);
  const localDateKey = (date = new Date()) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };
  const validDate = (value) => /^\d{4}-\d{2}-\d{2}$/.test(value)
    && !Number.isNaN(new Date(`${value}T00:00:00`).getTime());
  const validMetric = (value) => value === null
    || (typeof value === 'number' && Number.isFinite(value) && value >= 0);
  const validEntry = (entry) => entry !== null
    && typeof entry === 'object'
    && typeof entry.id === 'string'
    && validDate(entry.date)
    && Object.hasOwn(categories, entry.category)
    && typeof entry.activity === 'string'
    && typeof entry.notes === 'string'
    && Number.isFinite(entry.createdAt)
    && validMetric(entry.durationMinutes)
    && validMetric(entry.calories)
    && validMetric(entry.proteinGrams)
    && (entry.sleepHours === null
      || (typeof entry.sleepHours === 'number' && Number.isFinite(entry.sleepHours)
        && entry.sleepHours >= 0 && entry.sleepHours <= 24))
    && (entry.quality === null
      || (Number.isInteger(entry.quality) && entry.quality >= 1 && entry.quality <= 5));

  let entries = [];

  function setStatus(id, message, isError = false) {
    const status = byId(id);
    if (!status) return;
    status.textContent = message;
    status.classList.toggle('error', isError);
  }

  function setStorageError(error) {
    console.error('Could not load saved wellness history; existing data was left untouched.', error);
    setStatus('wellnessAnalysisStatus', 'Saved wellness history could not be read. Existing data was left untouched.', true);
  }

  function loadEntries() {
    try {
      const parsed = window.BlinkAppState.read(STORAGE_KEY, []);
      if (!Array.isArray(parsed) || !parsed.every(validEntry)) {
        throw new Error('Saved wellness data has an unexpected format.');
      }
      return parsed;
    } catch (error) {
      setStorageError(error);
      return [];
    }
  }

  function formatNumber(value, digits = 0) {
    return Number(value).toLocaleString(undefined, {
      maximumFractionDigits: digits,
      minimumFractionDigits: 0
    });
  }

  function appendText(parent, tag, className, text) {
    const element = document.createElement(tag);
    if (className) element.className = className;
    element.textContent = text;
    parent.appendChild(element);
    return element;
  }

  function readStoredObject(key, errors) {
    try {
      const parsed = window.BlinkAppState.read(key, {});
      if (parsed === null || typeof parsed !== 'object' || Array.isArray(parsed)) {
        throw new Error('Saved data has an unexpected format.');
      }
      return parsed;
    } catch (error) {
      console.error(`Could not read ${key}; existing data was left untouched.`, error);
      errors.push(key);
      return null;
    }
  }

  function currentDayData(date, errors) {
    const data = { foodCount: null, calories: null, protein: null, workouts: null, plannedWorkouts: null, focus: '', cardio: null, mindfulness: null, events: null };

    try {
      if (typeof items !== 'undefined' && typeof DB !== 'undefined' && typeof nutrient === 'function') {
        const foods = items.filter((item) => item && DB[item.key]);
        data.foodCount = foods.length;
        data.calories = foods.reduce((sum, item) => sum + (Number(nutrient(item, 'kcal')) || 0), 0);
        data.protein = foods.reduce((sum, item) => sum + (Number(nutrient(item, 'protein')) || 0), 0);
      } else {
        errors.push('Fuel');
      }
    } catch (error) {
      console.error('Could not read the Fuel tracker.', error);
      errors.push('Fuel');
    }

    try {
      if (typeof workoutLogs !== 'undefined' && typeof dayWorkoutPlan === 'function') {
        const plan = dayWorkoutPlan();
        data.plannedWorkouts = plan.length;
        data.workouts = plan.filter((exercise) => {
          const log = workoutLogs[exercise.id];
          return log?.done === true && log.completedOn === date;
        }).length;
        if (typeof gymDay === 'string' && typeof MY_SPLIT !== 'undefined') {
          data.focus = MY_SPLIT[gymDay]?.focus || '';
        }
      } else {
        errors.push('Train');
      }
    } catch (error) {
      console.error('Could not read the Train tracker.', error);
      errors.push('Train');
    }

    const cardioSessions = readStoredObject('blinkCardioSessions', errors);
    const legacyCardio = readStoredObject('blinkCardioLogs', errors);
    const cardioDataset = cardioSessions && Array.isArray(cardioSessions.sessions)
      ? cardioSessions.sessions
      : Array.isArray(legacyCardio ? legacyCardio.sessions : null)
        ? legacyCardio.sessions
        : (legacyCardio && typeof legacyCardio === 'object' ? legacyCardio : []);
    if (cardioDataset && cardioDataset.length) {
      const todayEntry = cardioDataset.filter((session) => session?.date === date).reduce((sum, session) => sum + (Number(session.distanceMeters) || 0), 0);
      if (typeof todayEntry === 'number' && Number.isFinite(todayEntry) && todayEntry >= 0) data.cardio = todayEntry;
      else errors.push('Cardio');
    } else if (cardioSessions && typeof cardioSessions === 'object' && !Array.isArray(cardioSessions)) {
      const value = cardioSessions[date] ?? 0;
      if (typeof value === 'number' && Number.isFinite(value) && value >= 0) data.cardio = value;
      else errors.push('Cardio');
    } else if (legacyCardio && typeof legacyCardio === 'object' && !Array.isArray(legacyCardio)) {
      const value = legacyCardio[date] ?? 0;
      if (typeof value === 'number' && Number.isFinite(value) && value >= 0) data.cardio = value;
      else errors.push('Cardio');
    }

    const mind = readStoredObject('blinkMind', errors);
    if (mind) {
      const value = mind.days?.[date] ?? 0;
      if (typeof value === 'number' && Number.isFinite(value) && value >= 0) data.mindfulness = value;
      else errors.push('Mind');
    }

    const calendar = readStoredObject('blinkCal', errors);
    if (calendar) {
      const events = calendar[date] ?? [];
      if (Array.isArray(events) && events.every((event) => Array.isArray(event) && typeof event[0] === 'string' && typeof event[1] === 'string')) {
        data.events = events.slice().sort((a, b) => a[0].localeCompare(b[0]));
      } else {
        errors.push('Plan');
      }
    }

    return data;
  }

  function appendTrackerEntry(list, label, title, detail, page) {
    const row = document.createElement('article');
    row.className = 'wellnessEntry';
    const main = document.createElement('div');
    main.className = 'wellnessEntryMain';
    const heading = document.createElement('div');
    heading.className = 'wellnessEntryHead';
    appendText(heading, 'span', 'wellnessEntryCategory', label);
    appendText(heading, 'strong', '', title);
    main.appendChild(heading);
    appendText(main, 'div', 'wellnessEntryMeta', detail);
    row.appendChild(main);

    const action = document.createElement('button');
    action.type = 'button';
    action.className = 'wellnessEntryAction';
    action.dataset.page = page;
    action.textContent = 'Open';
    action.setAttribute('aria-label', `Open ${label}`);
    row.appendChild(action);
    list.appendChild(row);
  }

  function renderEntries() {
    if (!byId('wellnessEntries')) return;
    const date = localDateKey();
    const errors = [];
    const data = currentDayData(date, errors);
    const list = byId('wellnessEntries');
    byId('wellnessTodayDate').textContent = new Date().toLocaleDateString(undefined, {
      weekday: 'long', month: 'long', day: 'numeric', year: 'numeric'
    });
    byId('wellnessDaySummary').textContent = `${data.events?.length ?? 0} calendar events today · updates automatically from your trackers`;

    byId('wellnessFuelCalories').textContent = data.calories === null ? '—' : `${formatNumber(data.calories)} kcal`;
    byId('wellnessFuelDetail').textContent = data.foodCount === null
      ? 'Fuel tracker unavailable'
      : `${data.foodCount} foods · ${formatNumber(data.protein, 1)} g protein`;
    byId('wellnessWorkoutProgress').textContent = data.workouts === null
      ? '—'
      : `${data.workouts}/${data.plannedWorkouts}`;
    byId('wellnessWorkoutDetail').textContent = data.workouts === null
      ? 'Train tracker unavailable'
      : `${data.focus ? `${data.focus} · ` : ''}completed today`;
    byId('wellnessCardioMinutes').textContent = data.cardio === null ? '—' : formatNumber(data.cardio);
    byId('wellnessMindMinutes').textContent = data.mindfulness === null ? '—' : formatNumber(data.mindfulness, 1);

    list.replaceChildren();
    appendTrackerEntry(
      list,
      'Fuel',
      `${data.foodCount ?? '—'} foods in your current plan`,
      data.calories === null ? 'Nutrition totals unavailable' : `${formatNumber(data.calories)} kcal · ${formatNumber(data.protein, 1)} g protein`,
      'diet'
    );
    appendTrackerEntry(
      list,
      'Train',
      data.workouts === null ? 'Training data unavailable' : `${data.workouts} of ${data.plannedWorkouts} exercises completed today`,
      data.focus || 'Completion is counted when you mark an exercise done today.',
      'gym'
    );
    appendTrackerEntry(
      list,
      'Cardio',
      data.cardio === null ? 'Cardio data unavailable' : `${formatNumber(data.cardio)} minutes today`,
      'From your daily cardio tracker.',
      'mind'
    );
    appendTrackerEntry(
      list,
      'Mind',
      data.mindfulness === null ? 'Mindfulness data unavailable' : `${formatNumber(data.mindfulness, 1)} minutes today`,
      'From your mindfulness timer.',
      'mind'
    );
    const event = data.events?.find((item) => item[0] >= new Date().toTimeString().slice(0, 5)) || data.events?.[0];
    appendTrackerEntry(
      list,
      'Plan',
      event ? `${event[1]} · ${event[0]}` : 'No calendar events planned',
      data.events?.length ? `${data.events.length} events scheduled today.` : 'Your calendar is clear for today.',
      'schedule'
    );

    const updatedAt = new Date().toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
    setStatus('wellnessLogStatus', errors.length
      ? `Updated ${updatedAt} · some tracker data could not be read (${[...new Set(errors)].join(', ')}).`
      : `Updated ${updatedAt} · fuel totals reflect your current Fuel list.`);
  }

  function entriesInRange(days) {
    const today = new Date();
    const firstDay = new Date(today.getFullYear(), today.getMonth(), today.getDate() - days + 1);
    const keys = Array.from({ length: days }, (_, index) => {
      const date = new Date(firstDay);
      date.setDate(firstDay.getDate() + index);
      return localDateKey(date);
    });
    const byDate = new Map(keys.map((key) => [key, []]));
    entries.forEach((entry) => {
      if (byDate.has(entry.date)) byDate.get(entry.date).push(entry);
    });
    return { keys, byDate };
  }

  function renderBarChart(containerId, data, options) {
    const container = byId(containerId);
    const maxValue = Math.max(0, ...data.map(options.value));
    container.dataset.range = String(data.length);
    container.style.setProperty('--wellness-days', String(data.length));
    container.replaceChildren();

    data.forEach((day) => {
      const column = document.createElement('div');
      column.className = 'wellnessBarDay';
      const value = options.value(day);
      appendText(column, 'span', 'wellnessBarValue', options.label(value));
      const stack = document.createElement('div');
      stack.className = 'wellnessBarStack';
      options.bars(day).forEach((bar) => {
        const element = document.createElement('i');
        element.className = `wellnessBar ${bar.className}`;
        element.style.height = `${bar.value > 0 ? Math.max(3, bar.value / maxValue * 100) : 0}%`;
        stack.appendChild(element);
      });
      column.appendChild(stack);
      const date = new Date(`${day.date}T00:00:00`);
      const label = data.length === 7
        ? date.toLocaleDateString(undefined, { weekday: 'short' })
        : data.length > 90
          ? date.getDate() === 1 ? date.toLocaleDateString(undefined, { month: 'short' }) : ''
          : String(date.getDate());
      appendText(column, 'small', '', label);
      const tooltip = options.tooltip(day);
      column.title = `${date.toLocaleDateString()}: ${tooltip}`;
      container.appendChild(column);
    });
  }

  function sleepEstimatesByDate() {
    try {
      const saved = window.BlinkAppState.read('blinkSleepEstimates', null);
      if (saved === null) return new Map();
      if (!saved || typeof saved !== 'object' || !Array.isArray(saved.estimates)) {
        throw new Error('Saved sleep estimates have an unexpected format.');
      }
      const byDate = new Map();
      saved.estimates.forEach((estimate) => {
        if (!estimate || !validDate(estimate.date) || !Number.isFinite(estimate.hours)
            || estimate.hours < 3 || estimate.hours > 14) return;
        const current = byDate.get(estimate.date);
        if (!current || Number(estimate.wakeTime) > Number(current.wakeTime)) byDate.set(estimate.date, estimate);
      });
      return byDate;
    } catch (error) {
      console.error('Could not read saved sleep estimates; existing data was left untouched.', error);
      setStatus('wellnessAnalysisStatus', 'Saved sleep estimates could not be read. Existing data was left untouched.', true);
      return new Map();
    }
  }

  function dailyHistoryByDate(key, validateEntry) {
    try {
      const saved = window.BlinkAppState.read(key, []);
      if (!Array.isArray(saved) || !saved.every(validateEntry)) {
        throw new Error(`Saved ${key} has an unexpected format.`);
      }
      return new Map(saved.map((entry) => [entry.date, entry]));
    } catch (error) {
      console.error(`Could not read ${key}; existing data was left untouched.`, error);
      setStatus('wellnessAnalysisStatus', 'Saved daily analysis data could not be read. Existing data was left untouched.', true);
      return null;
    }
  }

  function renderAnalysis() {
    const range = Number(byId('wellnessRange').value) || 7;
    const { keys, byDate } = entriesInRange(range);
    const sleepEstimates = sleepEstimatesByDate();
    const savedFuelHistory = dailyHistoryByDate('blinkFuelDailyHistory', (entry) =>
      entry && validDate(entry.date) && Number.isFinite(entry.calories) && entry.calories >= 0
        && Number.isFinite(entry.proteinGrams) && entry.proteinGrams >= 0
        && Number.isInteger(entry.foodCount) && entry.foodCount >= 0);
    const savedWorkoutHistory = dailyHistoryByDate('blinkWorkoutDailyHistory', (entry) =>
      entry && validDate(entry.date) && Array.isArray(entry.exerciseIds)
        && entry.exerciseIds.every((id) => typeof id === 'string'));
    const dailyHistoryError = savedFuelHistory === null || savedWorkoutHistory === null;
    const fuelHistory = savedFuelHistory || new Map();
    const workoutHistory = savedWorkoutHistory || new Map();
    let gymHistory = new Map();
    try {
      const savedGymData = window.BlinkAppState.read('blinkGymSessions', { sessions: [] });
      if (!savedGymData || typeof savedGymData !== 'object' || Array.isArray(savedGymData)
          || !Array.isArray(savedGymData.sessions)) {
        throw new Error('Saved gym sessions have an unexpected format.');
      }
      savedGymData.sessions.forEach((session) => {
        if (!session || !validDate(session.date)) return;
        gymHistory.set(session.date, (gymHistory.get(session.date) || 0) + 1);
      });
    } catch (error) {
      console.error('Could not read saved gym sessions; existing data was left untouched.', error);
      setStatus('wellnessAnalysisStatus', 'Saved gym history could not be read. Existing data was left untouched.', true);
      gymHistory = null;
    }
    const gymHistoryError = gymHistory === null;
    if (!gymHistory) gymHistory = new Map();
    const data = keys.map((date) => {
      const forDay = byDate.get(date);
      const food = forDay.filter((entry) => entry.category === 'food');
      const workouts = forDay.filter((entry) => entry.category === 'workout');
      const recovery = forDay.filter((entry) => entry.category === 'recovery');
      const total = (rows, field) => rows.reduce((sum, row) => sum + (row[field] || 0), 0);
      const sleepEntries = recovery.filter((entry) => entry.sleepHours !== null);
      const sleepEstimate = sleepEstimates.get(date);
      const fuelDay = fuelHistory.get(date);
      const workoutDay = workoutHistory.get(date);
      return {
        date,
        food,
        workouts,
        recovery,
        calories: food.length ? total(food, 'calories') : fuelDay?.calories || 0,
        protein: food.length ? total(food, 'proteinGrams') : fuelDay?.proteinGrams || 0,
        foodCount: food.length || fuelDay?.foodCount || 0,
        fuelLogged: food.length > 0 || Boolean(fuelDay),
        completedExercises: workoutDay?.exerciseIds.length || 0,
        gymVisits: gymHistory.get(date) || 0,
        workoutMinutes: total(workouts, 'durationMinutes'),
        recoveryMinutes: total(recovery, 'durationMinutes'),
        sleepHours: sleepEntries.length
          ? total(sleepEntries, 'sleepHours')
          : sleepEstimate ? sleepEstimate.hours : 0,
        sleepDays: sleepEntries.length || sleepEstimate ? 1 : 0
      };
    });
    const inRange = data.flatMap((day) => [...day.food, ...day.workouts, ...day.recovery]);
    const foodEntries = inRange.filter((entry) => entry.category === 'food');
    const workoutEntries = inRange.filter((entry) => entry.category === 'workout');
    const recoveryEntries = inRange.filter((entry) => entry.category === 'recovery');
    const total = (rows, field) => rows.reduce((sum, row) => sum + (row[field] || 0), 0);
    const totalCalories = total(foodEntries, 'calories');
    const totalWorkoutMinutes = total(workoutEntries, 'durationMinutes');
    const totalRecoveryMinutes = total(recoveryEntries, 'durationMinutes');
    const totalSleepHours = total(data, 'sleepHours');
    const sleepDays = data.filter((day) => day.sleepDays > 0).length;
    const fuelDays = data.filter((day) => day.fuelLogged).length;
    const totalFoodCount = data.reduce((sum, day) => sum + day.foodCount, 0);
    const totalPlannedCalories = data.reduce((sum, day) =>
      sum + (day.food.length ? 0 : day.calories), 0);
    const totalPlannedProtein = data.reduce((sum, day) =>
      sum + (day.food.length ? 0 : day.protein), 0);
    const totalWorkoutActivities = data.reduce((sum, day) =>
      sum + day.workouts.length + day.completedExercises + day.gymVisits, 0);

    byId('analysisFoodCount').textContent = formatNumber(foodEntries.length + fuelDays);
    byId('analysisFoodDetail').textContent = `${formatNumber(totalCalories + totalPlannedCalories)} kcal · ${formatNumber(total(foodEntries, 'proteinGrams') + totalPlannedProtein, 1)} g protein · ${formatNumber(totalFoodCount)} foods`;
    byId('analysisWorkoutTime').innerHTML = `${formatNumber(totalWorkoutMinutes)} <small>min</small>`;
    byId('analysisWorkoutDetail').textContent = `${formatNumber(data.reduce((sum, day) => sum + day.completedExercises, 0))} exercise completions · ${formatNumber(data.reduce((sum, day) => sum + day.gymVisits, 0))} gym visits · ${formatNumber(workoutEntries.length)} logged sessions`;
    byId('analysisRecoveryTime').innerHTML = `${formatNumber(totalRecoveryMinutes)} <small>min</small>`;
    byId('analysisRecoveryDetail').textContent = `${formatNumber(recoveryEntries.length)} recovery entries`;
    byId('analysisSleep').innerHTML = `${sleepDays ? formatNumber(totalSleepHours / sleepDays, 1) : '—'} <small>hrs</small>`;
    byId('wellnessRangeSummary').textContent = `${formatNumber(fuelDays)} food plan days · ${formatNumber(totalWorkoutActivities)} workout activities · ${formatNumber(sleepDays)} sleep days`;
    byId('foodChartTotal').textContent = `${formatNumber(totalCalories + totalPlannedCalories)} kcal`;
    byId('workoutChartTotal').textContent = `${formatNumber(totalWorkoutActivities)} activities`;
    byId('recoveryChartTotal').textContent = `${formatNumber(totalRecoveryMinutes)} min`;

    renderBarChart('foodActivityChart', data, {
      value: (day) => day.calories,
      label: (value) => value ? formatNumber(value) : '—',
      bars: (day) => [{ value: day.calories, className: '' }],
      tooltip: (day) => `${formatNumber(day.calories)} kcal, ${formatNumber(day.protein, 1)} g protein`
    });
    renderBarChart('workoutActivityChart', data, {
      value: (day) => day.workouts.length + day.completedExercises + day.gymVisits,
      label: (value) => value ? formatNumber(value) : '—',
      bars: (day) => [{ value: day.workouts.length + day.completedExercises + day.gymVisits, className: 'workoutBar' }],
      tooltip: (day) => `${formatNumber(day.completedExercises)} completed exercises, ${formatNumber(day.gymVisits)} gym visits, ${formatNumber(day.workouts.length)} logged workouts`
    });
    renderBarChart('recoveryActivityChart', data, {
      value: (day) => Math.max(day.recoveryMinutes, day.sleepHours * 30),
      label: (value) => value ? `${formatNumber(value)}m` : '—',
      bars: (day) => [
        { value: day.recoveryMinutes, className: 'recoveryBar' },
        { value: day.sleepHours * 30, className: 'sleepBar' }
      ],
      tooltip: (day) => `${formatNumber(day.recoveryMinutes)} recovery minutes, ${formatNumber(day.sleepHours, 1)} sleep hours`
    });

    byId('foodChartEmpty').style.display = foodEntries.length || fuelDays ? 'none' : 'block';
    byId('workoutChartEmpty').style.display = totalWorkoutActivities ? 'none' : 'block';
    byId('recoveryChartEmpty').style.display = recoveryEntries.length || sleepDays ? 'none' : 'block';
    if (!dailyHistoryError && !gymHistoryError) {
      setStatus('wellnessAnalysisStatus', inRange.length || fuelDays || totalWorkoutActivities
        ? 'Trends use locally saved food plans, workout completions, wellness entries and available sleep estimates.'
        : sleepDays
          ? 'Recovery includes Android sleep estimates where available; manual sleep entries take precedence.'
          : 'No saved wellness history for this period. Today’s summary is tracked automatically.');
    }
  }

  function initialize() {
    entries = loadEntries();
    byId('wellnessRange').addEventListener('change', renderAnalysis);
    byId('wellnessEntries')?.addEventListener('click', (event) => {
      const button = event.target.closest('button[data-page]');
      if (!button) return;
      const page = button.dataset.page;
      const navButton = [...document.querySelectorAll('.nav button')]
        .find((candidate) => candidate.getAttribute('onclick')?.includes(`tab('${page}'`));
      if (typeof window.tab === 'function') window.tab(page, navButton);
    });
    window.addEventListener('storage', (event) => {
      if (['blinkCardioLogs', 'blinkMind', 'blinkCal', 'blinkWorkoutLogs', 'blinkFoods',
        'blinkFuelDailyHistory', 'blinkWorkoutDailyHistory'].includes(event.key)) {
        renderEntries();
        return;
      }
      if (event.key === 'blinkSleepEstimates' || event.key === 'blinkWellnessLogs') {
        renderAnalysis();
        return;
      }
      if (event.key !== STORAGE_KEY) return;
      try {
        const parsed = event.newValue === null ? [] : JSON.parse(event.newValue);
        if (!Array.isArray(parsed) || !parsed.every(validEntry)) {
          throw new Error('Updated wellness data has an unexpected format.');
        }
        entries = parsed;
        renderAnalysis();
      } catch (error) {
        setStorageError(error);
      }
    });
    window.BlinkAppState.subscribe((_state, key) => {
      if (!['blinkCardioLogs', 'blinkMind', 'blinkCal', 'blinkWorkoutLogs', 'blinkFoods',
        'blinkFuelDailyHistory', 'blinkWorkoutDailyHistory',
        'blinkSleepEstimates', STORAGE_KEY, 'blinkCardioSessions', 'blinkGymSessions',
        'blinkStepHistory'].includes(key)) return;
      if (key === STORAGE_KEY) {
        const parsed = window.BlinkAppState.read(STORAGE_KEY, []);
        if (!Array.isArray(parsed) || !parsed.every(validEntry)) {
          setStorageError(new Error('Updated wellness data has an unexpected format.'));
          return;
        }
        entries = parsed;
      }
      renderEntries();
      renderAnalysis();
    });

    let updateQueued = false;
    const queueRefresh = () => {
      if (updateQueued) return;
      updateQueued = true;
      window.setTimeout(() => {
        updateQueued = false;
        renderEntries();
        renderAnalysis();
      }, 0);
    };
    ['click', 'input', 'change'].forEach((eventName) => {
      document.addEventListener(eventName, queueRefresh);
    });
    window.addEventListener('focus', queueRefresh);
    window.addEventListener('pageshow', queueRefresh);

    const sourceObserver = new MutationObserver(queueRefresh);
    ['tKcal', 'cardioTodayValue', 'mzToday', 'workoutTracker', 'calList'].forEach((id) => {
      const source = byId(id);
      if (source) sourceObserver.observe(source, { childList: true, characterData: true, subtree: true });
    });
    renderEntries();
    renderAnalysis();
  }

  initialize();
})();
