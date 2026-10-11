(() => {
  'use strict';

  const TRACKER_SETTINGS_KEY = 'blinkTrackerSettings';
  const CARDIO_KEY = 'blinkCardioSessions';
  const STEPS_KEY = 'blinkStepHistory';
  const GYM_KEY = 'blinkGymSessions';
  const SLEEP_KEY = 'blinkSleepEstimates';
  const APP_USAGE_HISTORY_KEY = 'blinkAppUsageHistory';
  const NIGHT_USAGE_HISTORY_KEY = 'blinkNightUsageHistory';
  const WORKOUT_HISTORY_KEY = 'blinkWorkoutDailyHistory';
  const WELLNESS_LOGS_KEY = 'blinkWellnessLogs';
  const LOCATION_HISTORY_PAGE_SIZE = 20;
  const byId = (id) => document.getElementById(id);
  const native = window.BlinkNative || null;
  let state = null;
  let appUsage = null;
  let appUsageError = null;
  let sleepAvailabilityStatus = null;
  let mapInstance = null;
  let mapMarker = null;
  let selectedGym = null;
  let leafletPromise = null;
  let mapCircle = null;
  let locationHistoryDate = dateKey(new Date());
  let loadedLocationHistoryDate = '';
  let locationHistoryRows = [];
  let locationHistoryVisibleCount = LOCATION_HISTORY_PAGE_SIZE;
  let locationHistoryStatus = '';
  let locationHistoryLoading = false;
  let locationHistoryYear = new Date().getFullYear();
  let locationHistoryYearRows = [];
  let locationHistoryYearStatus = '';
  let locationHistoryYearLoading = false;

  function readObject(key, fallback = {}) {
    const parsed = window.BlinkAppState.read(key, fallback);
    return parsed && typeof parsed === 'object' && !Array.isArray(parsed) ? parsed : fallback;
  }

  function saveIfChanged(key, value) {
    const serialized = JSON.stringify(value);
    try {
      if (localStorage.getItem(key) !== serialized) localStorage.setItem(key, serialized);
      return true;
    } catch (error) {
      console.error(`Could not save ${key}.`, error);
      const syncStatus = byId('nativeDataSyncStatus');
      if (syncStatus) syncStatus.textContent = `Could not save tracker data locally: ${error.message || 'storage unavailable.'}`;
      return false;
    }
  }

  function parseNativeState() {
    if (!native || typeof native.getTrackingState !== 'function') return null;
    try {
      const parsed = JSON.parse(native.getTrackingState());
      return parsed && typeof parsed === 'object' ? parsed : null;
    } catch (error) {
      console.error('Could not read Android tracking state.', error);
      return null;
    }
  }

  function mergeRows(first, second) {
    const result = new Map();
    [...(Array.isArray(first) ? first : []), ...(Array.isArray(second) ? second : [])]
      .forEach((entry) => {
        if (!entry || typeof entry !== 'object') return;
        const id = String(entry.id || '');
        const date = String(entry.date || '');
        const key = id || date;
        if (!key) return;
        const previous = result.get(key);
        if (!previous || Number(entry.endTime || entry.wakeTime || 0) >= Number(previous.endTime || previous.wakeTime || 0)) {
          result.set(key, entry);
        }
      });
    return [...result.values()].sort((a, b) =>
      Number(a.startTime || a.sleepStartTime || 0) - Number(b.startTime || b.sleepStartTime || 0));
  }

  function recordsFromStorage(key) {
    const value = readObject(key);
    return Array.isArray(value.sessions) ? value.sessions : [];
  }

  function syncNativeData(nextState) {
    if (!nextState) return;
    const cardioSessions = mergeRows(recordsFromStorage(CARDIO_KEY), nextState.cardioSessions);
    const gymSessions = mergeRows(recordsFromStorage(GYM_KEY), nextState.gymSessions);
    const sleepEstimates = mergeRows(readObject(SLEEP_KEY).estimates, nextState.sleepEstimates);
    const cardioActive = nextState.activeCardio || null;
    const localGym = readObject(GYM_KEY).location;
    const gymLocation = validCoordinates(localGym)
      ? localGym
      : validCoordinates(nextState.gymLocation)
        ? nextState.gymLocation : null;
    const gymValue = {
      sessions: gymSessions,
      activeSession: nextState.activeGymSession || null,
      inside: Boolean(nextState.gymInside),
      location: gymLocation
    };
    const cardioValue = { sessions: cardioSessions, activeSession: cardioActive };
    const sleepValue = { estimates: sleepEstimates, latest: nextState.sleepEstimate || null };
    const existingSteps = readObject(STEPS_KEY).days || {};
    const mergedSteps = { ...existingSteps };
    Object.entries(nextState.stepsByDay || {}).forEach(([date, count]) => {
      mergedSteps[date] = Math.max(Number(mergedSteps[date]) || 0, Number(count) || 0);
    });
    if (cardioSessions.length || cardioActive) saveIfChanged(CARDIO_KEY, cardioValue);
    if (gymSessions.length || gymValue.activeSession || gymValue.inside || gymLocation) saveIfChanged(GYM_KEY, gymValue);
    if (sleepEstimates.length || sleepValue.latest) saveIfChanged(SLEEP_KEY, sleepValue);
    if (Object.keys(mergedSteps).length) saveIfChanged(STEPS_KEY, { days: mergedSteps });
    if (gymLocation && native?.setSyncedGymLocation
        && (!nextState.gymLocation
          || Number(gymLocation.latitude) !== Number(nextState.gymLocation.latitude)
          || Number(gymLocation.longitude) !== Number(nextState.gymLocation.longitude)
          || Number(gymLocation.radiusMeters) !== Number(nextState.gymLocation.radiusMeters))) {
      try {
        native.setSyncedGymLocation(Number(gymLocation.latitude), Number(gymLocation.longitude),
          Number(gymLocation.radiusMeters) || 120);
      } catch (error) {
        console.error('Could not apply the synced gym geofence location.', error);
      }
    }

    if (typeof native.syncTrackingRecords === 'function'
        && (cardioSessions.length || gymSessions.length || sleepEstimates.length)) {
      try {
        native.syncTrackingRecords(JSON.stringify(cardioValue), JSON.stringify(gymValue), JSON.stringify(sleepValue));
      } catch (error) {
        console.error('Could not update Android tracking history from local storage.', error);
      }
    }
  }

  function currentSettings() {
    const saved = window.BlinkAppState.read(TRACKER_SETTINGS_KEY, {});
    return {
      locationEnabled: Boolean(state?.manualLocationEnabled ?? saved.locationEnabled),
      scheduleEnabled: Boolean(state?.scheduleEnabled ?? saved.scheduleEnabled ?? true),
      activityEnabled: Boolean(state?.activityEnabled ?? saved.activityEnabled),
      gymEnabled: Boolean(state?.gymEnabled ?? saved.gymEnabled),
      sleepEnabled: Boolean(state?.sleepEnabled ?? saved.sleepEnabled),
      sleepTargetHours: Number(state?.sleepTargetHours ?? saved.sleepTargetHours ?? 8)
    };
  }

  function status(text, kind = 'off') {
    return `<span class="nativeTrackerStatus" data-state="${kind}">${escapeText(text)}</span>`;
  }

  function escapeText(value) {
    const node = document.createElement('span');
    node.textContent = String(value ?? '');
    return node.innerHTML;
  }

  function validCoordinates(location) {
    if (!location || typeof location !== 'object') return false;
    const isNumeric = (value) => (typeof value === 'number' || typeof value === 'string')
      && String(value).trim() !== '';
    if (!isNumeric(location.latitude) || !isNumeric(location.longitude)) return false;
    const latitude = Number(location.latitude);
    const longitude = Number(location.longitude);
    return Number.isFinite(latitude) && latitude >= -90 && latitude <= 90
      && Number.isFinite(longitude) && longitude >= -180 && longitude <= 180;
  }

  async function loadLocationHistory(date) {
    locationHistoryLoading = true;
    locationHistoryStatus = 'Loading saved locations…';
    locationHistoryDate = date;
    render();
    try {
      if (!native || typeof native.getLocationHistory !== 'function') {
        throw new Error('This app build does not include saved location history. Install the latest APK.');
      }
      const response = JSON.parse(native.getLocationHistory(date));
      if (!Array.isArray(response)) {
        throw new Error(response?.error || 'The saved history response was invalid.');
      }
      locationHistoryRows = response.sort((first, second) =>
        Number(second.timestamp) - Number(first.timestamp));
      loadedLocationHistoryDate = date;
      locationHistoryVisibleCount = LOCATION_HISTORY_PAGE_SIZE;
      locationHistoryStatus = locationHistoryRows.length
        ? `${locationHistoryRows.length.toLocaleString()} saved location samples for ${formatDate(date)}.`
        : `No location samples were saved for ${formatDate(date)}. Tracking must be enabled to collect them.`;
    } catch (error) {
      console.error('Could not load saved location history.', error);
      locationHistoryStatus = `Location history could not be loaded: ${error.message || 'storage unavailable.'}`;
      locationHistoryRows = [];
      loadedLocationHistoryDate = date;
    } finally {
      locationHistoryLoading = false;
      render();
    }

    async function loadLocationHistoryYear(year) {
      const currentYear = new Date().getFullYear();
      const selectedYear = Number(year);
      if (!Number.isInteger(selectedYear) || selectedYear < 2000 || selectedYear > currentYear) {
        locationHistoryYearStatus = `Choose a year between 2000 and ${currentYear}.`;
        render();
        return;
      }
      locationHistoryYear = selectedYear;
      locationHistoryYearLoading = true;
      locationHistoryYearStatus = 'Analyzing saved location history…';
      render();
      try {
        if (!native || typeof native.getLocationHistoryYear !== 'function') {
          throw new Error('Install the latest BLINK APK to analyze location history.');
        }
        const response = JSON.parse(native.getLocationHistoryYear(selectedYear));
        if (!Array.isArray(response)) {
          throw new Error(response?.error || 'The yearly location summary was invalid.');
        }
        locationHistoryYearRows = response;
        locationHistoryYearStatus = `History analysis for ${selectedYear}. Estimated route distance uses adjacent saved GPS points.`;
      } catch (error) {
        console.error('Could not analyze yearly location history.', error);
        locationHistoryYearRows = [];
        locationHistoryYearStatus = `History analysis failed: ${error.message || 'storage unavailable.'}`;
      } finally {
        locationHistoryYearLoading = false;
        render();
      }
    }
  }

  function formatDuration(seconds) {
    const total = Math.max(0, Math.floor(Number(seconds) || 0));
    const hours = Math.floor(total / 3600);
    const minutes = Math.floor((total % 3600) / 60);
    return hours ? `${hours}h ${String(minutes).padStart(2, '0')}m` : `${minutes}m`;
  }

  function formatUsageDuration(milliseconds) {
    const total = Math.max(0, Number(milliseconds) || 0);
    return total > 0 && total < 60_000 ? '<1m' : formatDuration(total / 1000);
  }

  function saveUsageSnapshot(result) {
    if (!result?.granted || !Array.isArray(result.apps)) return;
    const now = new Date();
    const date = dateKey(now);
    const apps = result.apps.map((app) => ({
      name: String(app?.name || app?.label || app?.packageName || app?.package || '').trim(),
      milliseconds: Math.max(0, Number(app?.milliseconds) || 0)
    })).filter((app) => app.name && app.milliseconds > 0);
    const previousHistory = readObject(APP_USAGE_HISTORY_KEY, { days: {} });
    const usageDays = previousHistory.days && typeof previousHistory.days === 'object'
      ? previousHistory.days : {};
    const priorDaySnapshot = usageDays[date];
    const appTotals = Object.fromEntries(apps.map((app) => [app.name, app.milliseconds]));
    usageDays[date] = {
      date,
      sampledAt: now.getTime(),
      totalMilliseconds: apps.reduce((sum, app) => sum + app.milliseconds, 0),
      topApp: apps.slice().sort((first, second) => second.milliseconds - first.milliseconds)[0]?.name || '',
      apps
    };
    saveIfChanged(APP_USAGE_HISTORY_KEY, { days: usageDays });
    window.dispatchEvent(new CustomEvent('blink:usage-updated', { detail: { date } }));

    const inNightWindow = now.getHours() >= 23
      || now.getHours() < 6 || (now.getHours() === 6 && now.getMinutes() <= 30);
    if (!inNightWindow) return;
    const startDate = now.getHours() >= 23
      ? date
      : dateKey(new Date(now.getFullYear(), now.getMonth(), now.getDate() - 1));
    const nightHistory = readObject(NIGHT_USAGE_HISTORY_KEY, { days: {} });
    const nightDays = nightHistory.days && typeof nightHistory.days === 'object'
      ? nightHistory.days : {};
    const savedNight = nightDays[startDate] || { date: startDate, apps: {} };
    const baseline = savedNight.lastCalendarDate === date
      ? savedNight.lastApps || {}
      : (now.getHours() >= 23 && (!priorDaySnapshot
        || now.getTime() - Number(priorDaySnapshot.sampledAt || 0) > 15 * 60 * 1000)
        ? appTotals
        : (priorDaySnapshot?.apps || []).reduce((values, app) => {
        values[app.name] = Number(app.milliseconds) || 0;
        return values;
      }, {}));
    const nightApps = { ...(savedNight.apps || {}) };
    Object.entries(appTotals).forEach(([name, milliseconds]) => {
      const elapsed = Math.max(0, milliseconds - (Number(baseline[name]) || 0));
      if (elapsed) nightApps[name] = (Number(nightApps[name]) || 0) + elapsed;
    });
    nightDays[startDate] = {
      ...savedNight,
      date: startDate,
      sampledAt: now.getTime(),
      lastCalendarDate: date,
      lastApps: appTotals,
      apps: nightApps
    };
    saveIfChanged(NIGHT_USAGE_HISTORY_KEY, { days: nightDays });
    window.dispatchEvent(new CustomEvent('blink:usage-updated', { detail: { date: startDate } }));
  }

  function formatKm(meters) {
    return `${(Math.max(0, Number(meters) || 0) / 1000).toFixed(2)} km`;
  }

  function formatDate(date) {
    const parsed = new Date(`${date}T00:00:00`);
    return Number.isNaN(parsed.getTime())
      ? date
      : parsed.toLocaleDateString(undefined, { weekday: 'short', month: 'short', day: 'numeric' });
  }

  function dateKey(date) {
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
  }

  function historyRows(key) {
    const rows = window.BlinkAppState.read(key, []);
    if (!Array.isArray(rows)) {
      console.error(`Could not use ${key} for the weekly report: expected a list.`);
      return [];
    }
    return rows.filter((row) => row && /^\d{4}-\d{2}-\d{2}$/.test(String(row.date || '')));
  }

  function weeklyGraphMarkup() {
    const today = new Date();
    const monday = new Date(today.getFullYear(), today.getMonth(), today.getDate()
      - ((today.getDay() + 6) % 7));
    const days = Array.from({ length: 7 }, (_, index) => {
      const date = new Date(monday.getFullYear(), monday.getMonth(), monday.getDate() + index);
      return { date, key: dateKey(date), isFuture: date > today };
    });
    const workouts = new Map();
    historyRows(WORKOUT_HISTORY_KEY).forEach((row) => {
      const completedExercises = Array.isArray(row.exerciseIds) ? row.exerciseIds.length : 0;
      workouts.set(row.date, (workouts.get(row.date) || 0) + completedExercises);
    });
    const workoutLogs = new Map();
    historyRows(WELLNESS_LOGS_KEY).filter((row) => row.category === 'workout').forEach((row) => {
      workoutLogs.set(row.date, (workoutLogs.get(row.date) || 0) + 1);
    });
    const gyms = new Map();
    (Array.isArray(state?.gymSessions) ? state.gymSessions : []).forEach((row) => {
      if (row?.date) gyms.set(row.date, (gyms.get(row.date) || 0) + 1);
    });
    const cardio = new Map();
    (Array.isArray(state?.cardioSessions) ? state.cardioSessions : []).forEach((row) => {
      if (!row?.date) return;
      const current = cardio.get(row.date) || { meters: 0, sessions: 0 };
      current.meters += Math.max(0, Number(row.distanceMeters) || 0);
      current.sessions++;
      cardio.set(row.date, current);
    });
    if (state?.activeCardio) {
      const key = dateKey(today);
      const current = cardio.get(key) || { meters: 0, sessions: 0 };
      current.meters += Math.max(0, Number(state.activeCardio.distanceMeters) || 0);
      if (!current.sessions) current.sessions = 1;
      cardio.set(key, current);
    }
    const estimates = readObject(SLEEP_KEY).estimates;
    const recovery = new Map();
    (Array.isArray(estimates) ? estimates : []).forEach((row) => {
      if (!row?.date || !Number.isFinite(Number(row.recoveryPercent))) return;
      const current = recovery.get(row.date);
      if (!current || Number(row.windowEndTime || row.wakeTime || 0)
          >= Number(current.windowEndTime || current.wakeTime || 0)) recovery.set(row.date, row);
    });
    const values = days.map(({ key, isFuture }) => ({
      key,
      isFuture,
      exerciseCount: workouts.get(key) || 0,
      workoutCount: workoutLogs.get(key) || 0,
      gymCount: gyms.get(key) || 0,
      cardioMeters: cardio.get(key)?.meters || 0,
      cardioSessions: cardio.get(key)?.sessions || 0,
      recoveryPercent: recovery.has(key)
        ? Math.max(0, Math.min(100, Number(recovery.get(key).recoveryPercent))) : null
    }));
    const maxExercises = Math.max(1, ...values.map((day) =>
      day.exerciseCount + day.workoutCount + day.gymCount));
    const maxDistance = Math.max(1, ...values.map((day) => day.cardioMeters));
    const rowMarkup = (label, value, max, color, display) => `
      <div class="todayGraphRow">
        <span class="todayGraphLabel">${label}</span>
        ${values.map((day) => {
          const amount = value(day);
          const height = amount === null ? 0 : Math.max(0, Math.min(100, amount / max * 100));
          const shown = day.isFuture || amount === null ? '—' : display(amount, day);
          const title = day.isFuture ? 'Upcoming day'
            : amount === null ? 'No estimate recorded'
              : `${formatDate(day.key)}: ${shown}`;
          return `<div class="todayGraphDay" title="${escapeText(title)}">
            <span>${escapeText(shown)}</span>
            <i style="--graph-value:${height}%;--graph-color:${color}"></i>
          </div>`;
        }).join('')}
      </div>`;
    return `<article class="card todayWeeklyCard" aria-label="Weekly activity">
      <div class="todayGraphHeading"><h3>This week</h3></div>
      <div class="todayGraphWeekdays"><span></span>${days.map(({ date }) =>
        `<small>${escapeText(date.toLocaleDateString(undefined, { weekday: 'short' }))}</small>`).join('')}</div>
      <div class="todayGraphPlot" role="img" aria-label="Daily gym activity, cardio distance, and estimated recovery">
        ${rowMarkup('Gym', (day) => day.exerciseCount + day.workoutCount + day.gymCount,
          maxExercises, '#91a9ff', (amount) => `${amount}`)}
        ${rowMarkup('Cardio', (day) => day.cardioMeters, maxDistance, '#5ccbd5',
          (amount) => amount ? `${(amount / 1000).toFixed(1)} km` : '0 km')}
        ${rowMarkup('Recovery', (day) => day.recoveryPercent, 100, '#75d5b8',
          (amount) => `${Math.round(amount)}%`)}
      </div>
    </article>`;
  }

  function appUsageMarkup() {
    const granted = Boolean(appUsage?.granted ?? state?.usageAccessGranted);
    const apps = Array.isArray(appUsage?.apps) ? appUsage.apps
      .filter((app) => app && typeof app.name === 'string'
        && Number.isFinite(Number(app.milliseconds)) && Number(app.milliseconds) > 0)
      .sort((first, second) => Number(second.milliseconds) - Number(first.milliseconds)) : [];
    const topApp = apps[0];
    const statusText = !native ? 'App usage is available in the Android BLINK app.'
      : appUsageError ? `Could not read Android app usage: ${appUsageError}`
        : !granted ? 'Allow BLINK Usage Access to see foreground app time recorded today.'
          : apps.length ? 'Today’s foreground app activity from Android Usage Access.'
            : 'No app usage data recorded today.';
    return `<article class="card nativeTrackerCard" id="nativeAppUsageCard">
      <div class="nativeTrackerHeading"><div><h3>Phone app usage</h3><p>Foreground app time recorded today by Android</p></div>${status(granted ? 'Usage Access on' : 'Access needed', granted ? 'enabled' : 'required')}</div>
      <div class="usageHighlight"><div><span>TOP APP TODAY</span><strong>${escapeText(topApp
        ? `${topApp.name} · ${formatUsageDuration(topApp.milliseconds)}`
        : granted ? 'No usage recorded' : 'Usage Access required')}</strong></div><span class="usageMark">◷</span></div>
      <p class="nativeTrackerNote" id="nativeAppUsageStatus" role="status">${escapeText(statusText)}</p>
      <div class="appUsageList" aria-label="Apps used today">${apps.length
        ? apps.slice(0, 8).map((app) => `<div class="appUsageRow"><span>${escapeText(app.name)}</span><strong>${formatUsageDuration(app.milliseconds)}</strong></div>`).join('')
        : `<div class="nativeTrackerNote">${granted ? 'No app usage data recorded today.' : 'Grant Usage Access to view app activity.'}</div>`}</div>
      <div class="nativeTrackerActions"><button type="button" id="nativeRefreshAppUsage">Sync app usage</button>
        ${!granted ? '<button type="button" id="nativeOpenAppUsageAccess">Open Usage Access settings</button>' : ''}</div>
    </article>`;
  }

  function refreshAppUsage() {
    if (!native || typeof native.getAppUsageToday !== 'function') {
      appUsage = null;
      appUsageError = native ? 'The Android app-usage service is unavailable.' : null;
      if (typeof usageAccessGranted !== 'undefined') usageAccessGranted = false;
      if (typeof metricState !== 'undefined') {
        metricState.screen.value = 0;
        if (typeof updateMetrics === 'function') updateMetrics();
      }
      const screenAlert = byId('screenUsageAlertText');
      if (screenAlert) screenAlert.textContent = 'Phone app tracking is available in the Android BLINK app.';
      const target = byId('nativeAppUsageCard');
      if (target) target.outerHTML = appUsageMarkup();
      bindRenderedControls();
      return;
    }
    try {
      const result = JSON.parse(native.getAppUsageToday());
      if (!result || typeof result !== 'object' || Array.isArray(result)) {
        throw new Error('Android returned an invalid app-usage response.');
      }
      appUsage = result;
      appUsageError = result.error ? String(result.error) : null;
      saveUsageSnapshot(result);
      state = parseNativeState() || state;
      if (typeof usageAccessGranted !== 'undefined') usageAccessGranted = Boolean(result.granted);
      if (typeof metricState !== 'undefined') {
        const topApp = result.granted && Array.isArray(result.apps) ? result.apps
          .filter((app) => app && Number.isFinite(Number(app.milliseconds)))
          .sort((first, second) => Number(second.milliseconds) - Number(first.milliseconds))[0] : null;
        metricState.screen.value = topApp ? Math.floor(Number(topApp.milliseconds) / 60000) : 0;
        if (typeof updateMetrics === 'function') updateMetrics();
      }
    } catch (error) {
      appUsage = null;
      appUsageError = error.message || 'Usage data could not be loaded.';
      if (typeof usageAccessGranted !== 'undefined') usageAccessGranted = false;
      if (typeof metricState !== 'undefined') {
        metricState.screen.value = 0;
        if (typeof updateMetrics === 'function') updateMetrics();
      }
      const screenAlert = byId('screenUsageAlertText');
      if (screenAlert) screenAlert.textContent = 'Could not read app usage. Check Usage Access and sync again.';
      console.error('Could not read Android app usage.', error);
    }
    const target = byId('nativeAppUsageCard');
    if (target) target.outerHTML = appUsageMarkup();
    bindRenderedControls();
  }

  function locationStatus() {
    if (!native) return { label: 'Android app required', state: 'required' };
    const settings = currentSettings();
    const scheduledWindow = settings.scheduleEnabled
      && new Date().getHours() >= 6 && new Date().getHours() < 8;
    const requested = settings.locationEnabled || scheduledWindow
      || settings.activityEnabled || settings.gymEnabled;
    if (settings.scheduleEnabled && !settings.locationEnabled && !scheduledWindow
        && !state?.activeCardio) {
      return { label: 'Scheduled · off now', state: 'off' };
    }
    if (!requested && !state?.activeCardio && !state?.serviceRunning) {
      return { label: 'Tracking disabled', state: 'off' };
    }
    if (!state?.preciseLocationGranted
        || (scheduledWindow && !state?.backgroundLocationGranted)
        || (settings.activityEnabled && !state?.activityPermissionGranted)
        || (settings.gymEnabled && validCoordinates(state?.gymLocation)
          && !state?.backgroundLocationGranted)) {
      return { label: 'Permission required', state: 'required' };
    }
    if (state?.serviceError && !state?.serviceRunning) {
      return { label: 'Tracking needs attention', state: 'error' };
    }
    return { label: 'Tracking active', state: 'enabled' };
  }

  function liveLocationDetails() {
    if (!native || typeof native.getCurrentLocation !== 'function') return null;
    try {
      const location = JSON.parse(native.getCurrentLocation());
      if (validCoordinates(location)) {
        return {
          latitude: Number(location.latitude),
          longitude: Number(location.longitude),
          timestamp: Number(location.timestamp),
          accuracyMeters: location.accuracyMeters == null
            ? Number.NaN : Number(location.accuracyMeters)
        };
      }
    } catch (error) {
      console.error('Could not read the current Android location.', error);
    }
    return null;
  }

  function distanceMeters(first, second) {
    const radians = (degrees) => degrees * Math.PI / 180;
    const latitudeDelta = radians(Number(second.latitude) - Number(first.latitude));
    const longitudeDelta = radians(Number(second.longitude) - Number(first.longitude));
    const latitude1 = radians(Number(first.latitude));
    const latitude2 = radians(Number(second.latitude));
    const a = Math.sin(latitudeDelta / 2) ** 2
      + Math.cos(latitude1) * Math.cos(latitude2) * Math.sin(longitudeDelta / 2) ** 2;
    const bounded = Math.max(0, Math.min(1, a));
    return 6_371_000 * 2 * Math.atan2(Math.sqrt(bounded), Math.sqrt(1 - bounded));
  }

  function locationHistoryMarkup() {
    const rows = loadedLocationHistoryDate === locationHistoryDate
      ? locationHistoryRows.slice(0, locationHistoryVisibleCount) : [];
    const monthNames = Array.from({ length: 12 }, (_, index) =>
      new Date(2000, index, 1).toLocaleDateString(undefined, { month: 'short' }));
    const totals = locationHistoryYearRows.reduce((sum, month) => ({
      samples: sum.samples + Math.max(0, Number(month.samples) || 0),
      meters: sum.meters + Math.max(0, Number(month.distanceMeters) || 0)
    }), { samples: 0, meters: 0 });
    const maxDistance = Math.max(1, ...locationHistoryYearRows.map((month) =>
      Number(month.distanceMeters) || 0));
    const graph = locationHistoryYearRows.length === 12
      ? `<div class="locationYearGraph" role="img" aria-label="Estimated GPS distance by month during ${locationHistoryYear}">
        ${locationHistoryYearRows.map((month, index) => {
          const meters = Math.max(0, Number(month.distanceMeters) || 0);
          const height = Math.max(meters ? 5 : 0, meters / maxDistance * 100);
          return `<div class="locationYearMonth" title="${monthNames[index]}: ${(meters / 1000).toFixed(2)} km, ${Number(month.samples) || 0} samples">
            <strong>${meters ? `${(meters / 1000).toFixed(1)}` : '0'}</strong>
            <i style="--month-height:${height}%"></i><small>${monthNames[index]}</small>
          </div>`;
        }).join('')}
      </div>` : '';
    return `<section class="nativeLocationHistory" aria-label="Location history analysis">
      <h4>Location history &amp; analysis</h4>
      <p>Location history is stored on this device for as long as storage is available. GPS samples are saved about once a minute while tracking is on, including in the background.</p>
      <div class="nativeLocationHistoryControls"><input id="nativeLocationHistoryYear" type="number" min="2000" max="${new Date().getFullYear()}" value="${locationHistoryYear}">
        <button type="button" id="nativeAnalyzeLocationYear" ${locationHistoryYearLoading ? 'disabled' : ''}>${locationHistoryYearLoading ? 'Analyzing…' : 'Analyze year'}</button></div>
      <p class="nativeTrackerNote" role="status">${escapeText(locationHistoryYearStatus || 'Choose a year to view saved samples and estimated route distance.')}</p>
      ${graph ? `<div class="locationHistoryTotals"><div><span>Samples</span><strong>${totals.samples.toLocaleString()}</strong></div><div><span>Estimated route</span><strong>${formatKm(totals.meters)}</strong></div></div>${graph}` : ''}
      <div class="nativeLocationHistoryControls"><input id="nativeLocationHistoryDate" type="date" max="${dateKey(new Date())}" value="${escapeText(locationHistoryDate)}">
        <button type="button" id="nativeLoadLocationHistory" ${locationHistoryLoading ? 'disabled' : ''}>${locationHistoryLoading ? 'Loading…' : 'Show day'}</button></div>
      <p class="nativeTrackerNote" role="status">${escapeText(locationHistoryStatus || 'No location samples loaded for this day yet.')}</p>
      ${rows.length ? `<div class="nativeLocationHistoryRows">${rows.map((row) => {
        const mapUrl = `https://www.google.com/maps/search/?api=1&query=${Number(row.latitude)},${Number(row.longitude)}`;
        const accuracy = Number.isFinite(Number(row.accuracyMeters))
          ? ` · ±${Math.round(Number(row.accuracyMeters))} m` : '';
        return `<a class="nativeLocationHistoryRow" href="${mapUrl}" target="_blank" rel="noopener noreferrer">
          <span>${escapeText(new Date(Number(row.timestamp)).toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' }))}${accuracy}</span>
          <strong>${Number(row.latitude).toFixed(5)}, ${Number(row.longitude).toFixed(5)}</strong>
        </a>`;
      }).join('')}</div>` : ''}
      ${rows.length < locationHistoryRows.length ? '<button type="button" id="nativeMoreLocationHistory">Show older samples</button>' : ''}
    </section>`;
  }

  function cardioMarkup() {
    const today = new Date().toLocaleDateString('sv-SE');
    const active = state?.activeCardio;
    const location = locationStatus();
    const gpsPermission = !state?.preciseLocationGranted;
    const settings = currentSettings();
    const liveLocation = liveLocationDetails();
    const gymCandidate = validCoordinates(state?.gymLocation)
      ? state.gymLocation : readObject(GYM_KEY).location;
    const gymLocation = validCoordinates(gymCandidate) ? gymCandidate : null;
    const liveLocationText = liveLocation ? `${Number(liveLocation.latitude).toFixed(5)}, ${Number(liveLocation.longitude).toFixed(5)}` : 'Location unavailable';
    const locationAge = liveLocation && Number.isFinite(liveLocation.timestamp)
      ? Math.max(0, Date.now() - liveLocation.timestamp) : null;
    const freshLocation = liveLocation && locationAge !== null && locationAge <= 120_000
      ? liveLocation : null;
    const fixStatus = locationAge === null ? 'Waiting for a fresh GPS fix'
      : locationAge > 120_000 ? `GPS fix is old · ${formatDuration(locationAge / 1000)} ago`
        : `Updated ${formatDuration(locationAge / 1000)} ago${Number.isFinite(liveLocation.accuracyMeters) ? ` · accuracy ±${Math.round(liveLocation.accuracyMeters)} m` : ''}`;
    const gymDistance = freshLocation && gymLocation
      ? Math.round(distanceMeters(freshLocation, gymLocation)) : null;
    const gymRadius = Math.max(50, Number(gymLocation?.radiusMeters) || 120);
    const gymProximity = !gymLocation
      ? 'Choose a gym location on the map to check proximity.'
      : state?.gymInside && settings.gymEnabled ? 'Android geofence confirms you are inside the saved gym area.'
        : gymDistance === null ? 'Gym proximity needs a current GPS fix.'
        : gymDistance <= gymRadius ? `At saved gym · ${gymDistance} m from its center`
          : `${gymDistance} m from saved gym · geofence ${gymRadius} m`;
    const mapUrl = liveLocation
      ? `https://www.google.com/maps/search/?api=1&query=${liveLocation.latitude},${liveLocation.longitude}`
      : '';
    const sessions = Array.isArray(state?.cardioSessions) ? state.cardioSessions : [];
    const byDay = new Map();
    sessions.forEach((session) => {
      if (!session?.date) return;
      const day = byDay.get(session.date) || { meters: 0, duration: 0, sessions: 0 };
      day.meters += Number(session.distanceMeters) || 0;
      day.duration += Number(session.durationSeconds) || 0;
      day.sessions++;
      byDay.set(session.date, day);
    });
    const history = [...byDay.entries()].sort((a, b) => b[0].localeCompare(a[0])).slice(0, 7);
    const weekStart = new Date();
    weekStart.setDate(weekStart.getDate() - ((weekStart.getDay() + 6) % 7));
    const weekStartKey = weekStart.toLocaleDateString('sv-SE');
    const weekSessions = sessions.filter((session) =>
      session?.date >= weekStartKey && session.date <= today);
    const todayDistance = (byDay.get(today)?.meters || 0)
      + (active ? Number(active.distanceMeters) || 0 : 0);
    const weekDistance = weekSessions.reduce((sum, session) =>
      sum + (Number(session.distanceMeters) || 0), 0)
      + (active ? Number(active.distanceMeters) || 0 : 0);
    const activeSeconds = active ? (Date.now() - Number(active.startTime || Date.now())) / 1000 : 0;
    const activeDistance = active ? Number(active.distanceMeters) || 0 : 0;
    const activeAvgSpeed = activeSeconds > 0 ? (activeDistance / activeSeconds) * 3.6 : 0;
    const sensorStatus = !state?.activityEnabled
      ? 'Movement tracking disabled'
      : !state.activityPermissionGranted
        ? 'Motion permission required'
        : !state.stepSensorAvailable
          ? 'Motion sensor unavailable on this device'
          : 'Movement tracking active';
    return `<article class="card nativeTrackerCard" id="nativeCardioCard">
      <div class="nativeTrackerHeading"><div><h3>Live location</h3></div>${status(location.label, location.state)}</div>
      <div class="nativeTrackerLocation"><span>Current location</span><strong>${escapeText(liveLocationText)}</strong>${liveLocation
        ? `<a href="${mapUrl}" target="_blank" rel="noopener noreferrer">Open in Maps</a>`
        : `<small>${gpsPermission ? 'Allow BLINK location access to get a fix.' : settings.locationEnabled ? 'Waiting for a GPS fix. Check that device Location is turned on.' : 'Start live location to get a current GPS fix.'}</small>`}</div>
      <p class="nativeTrackerNote">${escapeText(fixStatus)}</p>
      <div class="nativeLocationGymStatus"><b>Gym proximity</b><span>${escapeText(gymProximity)}</span></div>
      ${!settings.locationEnabled ? '<div class="nativeTrackerActions"><button type="button" class="primary" id="nativeEnableLiveLocation">Start live location</button></div>' : '<div class="nativeTrackerActions"><button type="button" id="nativeDisableLiveLocation">Stop manual location</button></div>'}
      ${settings.scheduleEnabled && !state?.backgroundLocationGranted
        ? '<div class="nativeTrackerActions"><button type="button" id="nativeRequestSchedulePermission">Allow scheduled background location</button></div>' : ''}
      <div class="nativeTrackerMetrics">
        <div class="nativeTrackerMetric"><span>GPS today</span><strong>${formatKm(todayDistance)}</strong></div>
        <div class="nativeTrackerMetric"><span>This week</span><strong>${formatKm(weekDistance)}</strong></div>
        <div class="nativeTrackerMetric"><span>Sessions</span><strong>${weekSessions.length + (active ? 1 : 0)}</strong></div>
      </div>
      <p class="nativeTrackerNote">${escapeText(sensorStatus)} · ${weekSessions.length + (active ? 1 : 0)} GPS session${weekSessions.length + (active ? 1 : 0) === 1 ? '' : 's'} this week</p>
      ${active ? `<div class="nativeTrackerMetrics">
        <div class="nativeTrackerMetric"><span>Live session</span><strong>${formatDuration(activeSeconds)}</strong></div>
        <div class="nativeTrackerMetric"><span>Walking</span><strong>${formatDuration(active.walkingSeconds)}</strong></div>
        <div class="nativeTrackerMetric"><span>Running</span><strong>${formatDuration(active.runningSeconds)}</strong></div>
      </div>` : ''}
      <div class="nativeTrackerActions">
        ${active
          ? '<button type="button" class="primary" id="nativeCardioStop">Finish cardio session</button>'
          : `<button type="button" class="primary" id="nativeCardioStart" ${!native ? 'disabled' : ''}>${gpsPermission ? 'Grant location & start cardio' : 'Start GPS cardio'}</button>`}
        ${gpsPermission ? '<button type="button" id="nativeRequestLocation">Review location permission</button>' : ''}
      </div>
      <p class="nativeTrackerNote">${state?.serviceError ? escapeText(state.serviceError) : active ? `GPS is recording · ${formatKm(activeDistance)} · ${activeAvgSpeed.toFixed(1)} km/h average.` : 'GPS distance is recorded only during a session you start.'}</p>
      <div class="nativeTrackerHistory" aria-label="Cardio history by day">${history.length
        ? history.map(([date, day]) => `<div class="nativeTrackerHistoryRow"><span>${formatDate(date)} · ${day.sessions} session${day.sessions === 1 ? '' : 's'}</span><strong>${formatKm(day.meters)} · ${formatDuration(day.duration)}</strong></div>`).join('')
        : '<div class="nativeTrackerNote">No completed native GPS cardio sessions saved yet.</div>'}</div>
    </article>`;
  }

  function gymMarkup() {
    const settings = currentSettings();
    const storedLocation = readObject(GYM_KEY).location;
    const location = validCoordinates(state?.gymLocation) ? state.gymLocation
      : validCoordinates(storedLocation) ? storedLocation : null;
    const active = state?.activeGymSession;
    const recent = (Array.isArray(state?.gymSessions) ? state.gymSessions : [])
      .slice().sort((a, b) => Number(b.startTime || 0) - Number(a.startTime || 0)).slice(0, 5);
    const gymStatus = !native
      ? { label: 'Android app required', state: 'required' }
      : !settings.gymEnabled
        ? { label: 'Detection disabled', state: 'off' }
        : !location
          ? { label: 'Gym location not configured', state: 'required' }
        : !state?.backgroundLocationGranted
          ? { label: 'Background permission required', state: 'required' }
          : active || state?.gymInside
            ? { label: 'At Gym · presence detected', state: 'enabled' }
            : { label: 'Detection enabled', state: 'enabled' };
    const savedCoordinates = location
      ? `${Number(location.latitude).toFixed(5)}, ${Number(location.longitude).toFixed(5)} · ${Math.round(Number(location.radiusMeters) || 120)} m`
      : 'Gym location not configured';
    const savedRadius = Math.max(50, Number(location?.radiusMeters) || 120);
    return `<article class="card nativeTrackerCard" id="nativeGymCard">
      <div class="nativeTrackerHeading"><div><h3>Gym presence</h3><p>Geofence presence is not an exercise or completed workout.</p></div>${status(gymStatus.label, gymStatus.state)}</div>
      <div class="nativeGymPresence">${active
        ? `At Gym since ${new Date(Number(active.startTime)).toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' })}. Presence duration ${formatDuration((Date.now() - Number(active.startTime)) / 1000)}.`
        : state?.gymInside ? 'Inside your saved geofence. Gym sessions are only recorded from 4:30 PM to 7:30 PM.' : 'No gym presence session is active.'}</div>
      <p class="nativeTrackerNote">Saved location: <strong>${escapeText(savedCoordinates)}</strong></p>
      ${settings.gymEnabled && location && !state?.backgroundLocationGranted
        ? '<div class="nativeTrackerActions"><button type="button" id="nativeRequestGymPermissions">Review background location permission</button></div>' : ''}
      <div class="nativeTrackerHistory">${recent.length
        ? recent.map((session) => `<div class="nativeTrackerHistoryRow"><span>${formatDate(session.date)} · Gym presence</span><strong>${formatDuration(session.durationSeconds)}</strong></div>`).join('')
        : '<div class="nativeTrackerNote">No detected gym presence sessions yet.</div>'}</div>
      <div class="nativeTrackerActions"><button type="button" id="nativeOpenGymMap">Choose gym on map</button></div>
      <div class="nativeMapWrap" id="nativeGymMapWrap" hidden>
        <p class="nativeTrackerNote">Map selection only saves a geofence center. The map centers on your current location when available.</p>
        <div id="nativeGymMap" class="nativeMap" aria-label="Map to select the gym geofence center"></div>
        <div class="nativeMapAttribution">© OpenStreetMap contributors · tap the map to place the gym geofence.</div>
        <p class="nativeTrackerNote">If the map does not load, enter the gym coordinates manually.</p>
        <div class="nativeGymCoordinates"><label for="nativeGymLatitude">Latitude<input id="nativeGymLatitude" type="number" min="-90" max="90" step="0.000001" inputmode="decimal" value="${location ? Number(location.latitude) : ''}"></label>
          <label for="nativeGymLongitude">Longitude<input id="nativeGymLongitude" type="number" min="-180" max="180" step="0.000001" inputmode="decimal" value="${location ? Number(location.longitude) : ''}"></label></div>
        <label class="nativeTrackerNote" for="nativeGymRadius">Geofence radius <span id="nativeGymRadiusValue">${savedRadius} m</span></label>
        <input id="nativeGymRadius" type="range" min="50" max="500" step="10" value="${savedRadius}">
        <div id="nativeGymMapStatus" class="nativeMapStatus" role="status">Select a point, then save the geofence center.</div>
        <div class="nativeTrackerActions"><button type="button" id="nativeUseCurrentGymLocation">Use current GPS</button><button type="button" id="nativeUseGymCoordinates">Use coordinates</button><button type="button" class="primary" id="nativeSaveGymLocation" disabled>Save gym location</button><button type="button" id="nativeCloseGymMap">Close map</button></div>
      </div>
    </article>`;
  }

  function gymSummaryMarkup() {
    const today = new Date().toLocaleDateString('sv-SE');
    const weekStart = new Date();
    weekStart.setDate(weekStart.getDate() - ((weekStart.getDay() + 6) % 7));
    const weekStartKey = weekStart.toLocaleDateString('sv-SE');
    const sessions = Array.isArray(state?.gymSessions) ? state.gymSessions : [];
    const todayVisits = sessions.filter((session) => session?.date === today).length;
    const weekVisits = sessions.filter((session) =>
      session?.date >= weekStartKey && session.date <= today).length;
    const settings = currentSettings();
    const gymStatus = !native
      ? { label: 'Android app required', state: 'required' }
      : !settings.gymEnabled
        ? { label: 'Detection off', state: 'off' }
        : state?.activeGymSession || state?.gymInside
          ? { label: 'Gym presence detected', state: 'enabled' }
          : { label: 'Detection enabled', state: 'enabled' };
    const active = state?.activeGymSession;
    return `<article class="card nativeTrackerCard todayGymSummary" id="todayGymSummary">
      <div class="nativeTrackerHeading"><div><h3>Gym activity</h3>
        <p>${active ? `Since ${new Date(Number(active.startTime)).toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' })}` : state?.gymInside ? 'At your gym' : 'No visit now'}</p>
      </div>${status(gymStatus.label, gymStatus.state)}</div>
      <div class="nativeTrackerMetrics">
        <div class="nativeTrackerMetric"><span>Visits today</span><strong>${todayVisits}</strong></div>
        <div class="nativeTrackerMetric"><span>This week</span><strong>${weekVisits} visit${weekVisits === 1 ? '' : 's'}</strong></div>
      </div>
      <div class="nativeTrackerActions"><button type="button" class="primary" onclick="tab('gym',document.querySelector('.nav button[aria-label=Train]'))">Open gym</button></div>
    </article>`;
  }

  function sleepMarkup() {
    const settings = currentSettings();
    const savedEstimates = readObject(SLEEP_KEY).estimates;
    const estimates = Array.isArray(savedEstimates) ? savedEstimates : [];
    const estimate = [state?.sleepEstimate, ...estimates]
      .filter((entry) => entry && Number.isFinite(Number(entry.nightPhoneUseMs))
        && Number.isFinite(Number(entry.phoneFreeMs))
        && Number.isFinite(Number(entry.recoveryPercent)))
      .sort((left, right) => String(right.date || '').localeCompare(String(left.date || '')))[0] || null;
    const recoveryPercent = estimate
      ? Math.max(0, Math.min(100, Math.round(Number(estimate.recoveryPercent)))) : null;
    const recoveryStatus = !settings.sleepEnabled ? 'Turn on in Settings'
      : !state?.usageAccessGranted ? 'Allow Usage Access'
        : sleepAvailabilityStatus === 'unavailable' ? 'Usage data unavailable'
          : estimate ? `Estimated · ${formatDate(estimate.date)}` : 'No estimate yet';
    const nightUsage = estimate
      ? readObject(NIGHT_USAGE_HISTORY_KEY, { days: {} }).days?.[estimate.date] : null;
    const nightApps = nightUsage?.apps && typeof nightUsage.apps === 'object'
      ? Object.entries(nightUsage.apps).sort((first, second) => Number(second[1]) - Number(first[1])).slice(0, 8) : [];
    return `<article class="card nativeTrackerCard" id="nativeSleepCard">
      <div class="nativeTrackerHeading"><div><h3>Recovery</h3><p>${recoveryStatus}</p></div></div>
      <div class="nativeRecoveryScore"><strong>${recoveryPercent === null ? '—' : `${recoveryPercent}%`}</strong><span>Recovery</span></div>
      <div class="nativeRecoveryProgress" role="meter" aria-label="Estimated recovery" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${recoveryPercent ?? 0}" aria-valuetext="${recoveryPercent === null ? 'No estimate yet' : recoveryPercent + '%'}"><i style="width:${recoveryPercent ?? 0}%"></i></div>
      <details class="nativeRecoveryDetails"><summary>Night phone use · 11:00 PM–6:30 AM</summary>
        <div class="nativeRecoveryDetailMetrics"><div><span>Phone use</span><strong>${estimate ? formatUsageDuration(estimate.nightPhoneUseMs) : '—'}</strong></div>
          <div><span>Phone-free</span><strong>${estimate ? formatUsageDuration(estimate.phoneFreeMs) : '—'}</strong></div></div>
        ${nightApps.length ? `<div class="nativeTrackerHistory">${nightApps.map(([name, milliseconds]) => `<div class="nativeTrackerHistoryRow"><span>${escapeText(name)}</span><strong>${formatUsageDuration(milliseconds)}</strong></div>`).join('')}</div>` : '<p class="nativeTrackerNote">Per-app night detail is collected from app-usage snapshots while BLINK is active. Unsampled time is not inferred.</p>'}
      </details>
      <div class="nativeTrackerActions"><button type="button" id="nativeRefreshSleep">Refresh</button>
        ${settings.sleepEnabled && !state?.usageAccessGranted ? '<button type="button" id="nativeOpenUsageAccess">Usage Access</button>' : ''}</div>
    </article>`;
  }

  function settingRow(id, title, description, checked) {
    return `<div class="settingRow"><div><b>${title}</b><small>${description}</small></div><div class="settingControl"><input class="nativeTrackerToggle" id="${id}" type="checkbox" ${checked ? 'checked' : ''}></div></div>`;
  }

  function settingsMarkup() {
    const settings = currentSettings();
    return `<div class="settingsGroup nativeTrackerSettings" id="nativeTrackerSettings">
      <div class="settingsGroupHead"><span>◉</span> Device tracking</div>
      <div class="settingsRows">
        ${settingRow('nativeLocationEnabled', 'Live Location', 'Automatically update your location while enabled. Morning schedule can collect separately when manual tracking is off.', settings.locationEnabled)}
        ${settingRow('nativeLocationScheduleEnabled', 'Morning Location Schedule', 'Automatically collect GPS from 6:00–8:00 AM daily. It turns off outside those hours unless you manually start location.', settings.scheduleEnabled)}
        ${settingRow('nativeActivityEnabled', 'Activity Tracking', 'Uses the device motion sensor for movement updates.', settings.activityEnabled)}
        ${settingRow('nativeGymEnabled', 'Gym Detection', 'Android background geofence · presence only, 4:30 PM–7:30 PM.', settings.gymEnabled)}
        ${settingRow('nativeSleepEnabled', 'Night Recovery', 'Uses Android foreground app activity from 11:00 PM–6:30 AM to estimate phone-free time. Not medical sleep tracking.', settings.sleepEnabled)}
        <div class="settingRow"><div><b>Permission state</b><small id="nativePermissionSummary">Checking Android permissions…</small></div><div class="settingControl">${status(locationStatus().label, locationStatus().state)}</div></div>
      </div>
      <p class="nativeTrackerNote">Automatic background collection needs Android background location permission so its morning schedule can work when BLINK is closed. Live location can be stopped separately.</p>
      <div class="nativeSettingsLocation"><span>LIVE LOCATION STATUS</span><strong id="nativeSettingsLocationValue">${escapeText(liveLocationDetails() ? `${Number(liveLocationDetails().latitude).toFixed(5)}, ${Number(liveLocationDetails().longitude).toFixed(5)}` : 'Waiting for a GPS fix')}</strong><small id="nativeSettingsLocationState">${escapeText(locationStatus().label)}</small>${!state?.preciseLocationGranted ? '<button type="button" id="nativeSettingsOpenLocation">Open location permission settings</button>' : ''}</div>
      <p class="nativeTrackerNote">Native measurements are stored on this device and in BLINK’s local storage.</p>
      <p class="nativeTrackerNote" id="nativeDataSyncStatus" role="status"></p>
    </div>`;
  }

  function render() {
    const cardio = byId('nativeCardioCard');
    const gym = byId('nativeGymCard');
    const sleep = byId('nativeSleepCard');
    const todayGym = byId('todayGymSummary');
    const weeklyGraph = byId('todayWeeklyGraph');
    const appUsageCard = byId('nativeAppUsageCard');
    if (cardio) cardio.outerHTML = cardioMarkup();
    if (gym && byId('nativeGymMapWrap')?.hidden !== false) gym.outerHTML = gymMarkup();
    if (sleep) sleep.outerHTML = sleepMarkup();
    if (todayGym) todayGym.outerHTML = gymSummaryMarkup();
    if (weeklyGraph) weeklyGraph.innerHTML = weeklyGraphMarkup();
    if (appUsageCard) appUsageCard.outerHTML = appUsageMarkup();
    const summary = byId('nativePermissionSummary');
    const storedSettings = readObject(TRACKER_SETTINGS_KEY);
    const settings = Object.keys(storedSettings).length
      ? { ...currentSettings(), ...storedSettings }
      : currentSettings();
    [
      ['nativeLocationEnabled', settings.locationEnabled],
      ['nativeLocationScheduleEnabled', settings.scheduleEnabled],
      ['nativeActivityEnabled', settings.activityEnabled],
      ['nativeGymEnabled', settings.gymEnabled],
      ['nativeSleepEnabled', settings.sleepEnabled]
    ].forEach(([id, checked]) => {
      if (byId(id)) byId(id).checked = Boolean(checked);
    });
    renderTodayCardioControl();
    updateGymDisclosureSummary();
    const settingsLocation = liveLocationDetails();
    const settingsLocationValue = byId('nativeSettingsLocationValue');
    const settingsLocationState = byId('nativeSettingsLocationState');
    if (settingsLocationValue) settingsLocationValue.textContent = settingsLocation
      ? `${Number(settingsLocation.latitude).toFixed(5)}, ${Number(settingsLocation.longitude).toFixed(5)}`
      : 'Waiting for a GPS fix';
    if (settingsLocationState) settingsLocationState.textContent = locationStatus().label;
    if (summary) {
      const liveLocation = liveLocationDetails();
      const liveLocationText = liveLocation
        ? `${Number(liveLocation.latitude).toFixed(5)}, ${Number(liveLocation.longitude).toFixed(5)}`
        : 'Location unavailable';
      summary.textContent = state
        ? `Precise location: ${state.preciseLocationGranted ? 'granted' : 'permission required'} · Background location: ${state.backgroundLocationGranted ? 'granted' : 'permission required'} · Morning schedule: ${settings.scheduleEnabled ? '6:00–8:00 AM daily' : 'off'} · Live location: ${liveLocationText} · Usage Access: ${state.usageAccessGranted ? 'granted' : 'permission required'}`
        : 'Native tracking is available in the Android BLINK app.';
    }
    bindRenderedControls();
  }

  function renderTodayCardioControl() {
    const button = byId('todayCardioToggle');
    const label = byId('todayCardioState');
    if (!button || !label) return;
    const active = Boolean(state?.activeCardio);
    const available = Boolean(native && typeof native.startCardio === 'function'
      && typeof native.stopCardio === 'function');
    button.disabled = !available;
    button.dataset.state = !available ? 'required' : active ? 'on' : 'off';
    button.setAttribute('aria-pressed', String(active));
    button.setAttribute('aria-label', !available
      ? 'GPS cardio tracking requires the Android app'
      : active ? 'Stop GPS cardio tracking' : 'Start GPS cardio tracking');
    button.title = !available ? 'GPS cardio tracking requires the Android app'
      : active ? 'Stop GPS cardio tracking' : 'Start GPS cardio tracking';
    label.textContent = !available ? 'ANDROID APP'
      : active ? 'GPS ON' : 'GPS OFF';
  }

  function updateGymDisclosureSummary() {
    const summary = byId('nativeGymDisclosureSummary');
    if (!summary) return;
    const active = Boolean(state?.activeGymSession || state?.gymInside);
    const visits = (Array.isArray(state?.gymSessions) ? state.gymSessions : [])
      .filter((session) => session?.date === dateKey(new Date())).length;
    summary.innerHTML = `<span><strong>Gym presence</strong><small>${active ? 'Detected now' : 'Automatic detection'} · ${visits} today</small></span>${status(active ? 'AT GYM' : 'READY', active ? 'enabled' : 'off')}<i aria-hidden="true">+</i>`;
  }

  function toggleCardioTracking() {
    if (!native) return;
    try {
      if (state?.activeCardio) native.stopCardio();
      else native.startCardio();
      refresh();
    } catch (error) {
      console.error('Could not toggle native GPS cardio tracking.', error);
      const label = byId('todayCardioState');
      if (label) label.textContent = 'CHECK PERMISSION';
    }
  }

  function bindRenderedControls() {
    byId('nativeLoadLocationHistory')?.addEventListener('click', () => {
      const date = byId('nativeLocationHistoryDate')?.value || dateKey(new Date());
      loadLocationHistory(date);
    });
    byId('nativeAnalyzeLocationYear')?.addEventListener('click', () => {
      loadLocationHistoryYear(byId('nativeLocationHistoryYear')?.value);
    });
    byId('nativeMoreLocationHistory')?.addEventListener('click', () => {
      locationHistoryVisibleCount += LOCATION_HISTORY_PAGE_SIZE;
      render();
    });
    byId('nativeEnableLiveLocation')?.addEventListener('click', () => {
      const toggle = byId('nativeLocationEnabled');
      if (!toggle) return;
      toggle.checked = true;
      toggle.dispatchEvent(new Event('change', { bubbles: true }));
    });
    byId('nativeDisableLiveLocation')?.addEventListener('click', () => {
      const toggle = byId('nativeLocationEnabled');
      if (!toggle) return;
      toggle.checked = false;
      toggle.dispatchEvent(new Event('change', { bubbles: true }));
    });
    byId('nativeCardioStart')?.addEventListener('click', () => {
      if (!native) return;
      try { native.startCardio(); refresh(); }
      catch (error) { console.error('Could not start native cardio tracking.', error); }
    });
    byId('nativeCardioStop')?.addEventListener('click', () => {
      if (!native) return;
      try { native.stopCardio(); refresh(); }
      catch (error) { console.error('Could not finish native cardio tracking.', error); }
    });
    byId('nativeRequestLocation')?.addEventListener('click', () => {
      native?.openAppLocationSettings();
    });
    const settingsLocationButton = byId('nativeSettingsOpenLocation');
    if (settingsLocationButton && settingsLocationButton.dataset.bound !== 'true') {
      settingsLocationButton.dataset.bound = 'true';
      settingsLocationButton.addEventListener('click', () => native?.openAppLocationSettings());
    }
    byId('nativeRequestSchedulePermission')?.addEventListener('click', () => {
      native?.requestGymDetectionPermissions();
    });
    byId('nativeRefreshSleep')?.addEventListener('click', refreshSleep);
    byId('nativeOpenUsageAccess')?.addEventListener('click', () => native?.openUsageAccessSettings());
    byId('nativeRefreshAppUsage')?.addEventListener('click', refreshAppUsage);
    byId('nativeOpenAppUsageAccess')?.addEventListener('click', () => native?.openUsageAccessSettings());
    byId('nativeOpenGymMap')?.addEventListener('click', openGymMap);
    byId('nativeRequestGymPermissions')?.addEventListener('click', () => native?.requestGymDetectionPermissions());
    byId('nativeCloseGymMap')?.addEventListener('click', () => {
      const wrap = byId('nativeGymMapWrap');
      if (wrap) wrap.hidden = true;
      mapInstance?.remove();
      mapInstance = null;
      selectedGym = null;
      mapMarker = null;
      mapCircle = null;
    });
    byId('nativeSaveGymLocation')?.addEventListener('click', saveGymLocation);
    byId('nativeUseCurrentGymLocation')?.addEventListener('click', () => {
      try {
        const location = native?.getCurrentLocation
          ? JSON.parse(native.getCurrentLocation()) : null;
        if (!validCoordinates(location)) {
          byId('nativeGymMapStatus').textContent = 'Current GPS is unavailable. Enable Live Location or enter coordinates manually.';
          return;
        }
        setMapSelection(Number(location.latitude), Number(location.longitude),
          Number(byId('nativeGymRadius')?.value) || 120);
      } catch (error) {
        byId('nativeGymMapStatus').textContent = `Could not read current GPS: ${error.message || 'location unavailable.'}`;
      }
    });
    byId('nativeUseGymCoordinates')?.addEventListener('click', () => {
      const latitudeValue = byId('nativeGymLatitude')?.value.trim();
      const longitudeValue = byId('nativeGymLongitude')?.value.trim();
      if (!latitudeValue || !longitudeValue) {
        byId('nativeGymMapStatus').textContent = 'Enter both latitude and longitude, or use current GPS.';
        return;
      }
      const latitude = Number(latitudeValue);
      const longitude = Number(longitudeValue);
      const radius = Number(byId('nativeGymRadius')?.value) || 120;
      setMapSelection(latitude, longitude, radius);
    });
    const todayCardioToggle = byId('todayCardioToggle');
    if (todayCardioToggle && todayCardioToggle.dataset.bound !== 'true') {
      todayCardioToggle.dataset.bound = 'true';
      todayCardioToggle.addEventListener('click', toggleCardioTracking);
    }
  }

  function saveSettings() {
    if (!native) return;
    const target = Number(byId('nativeSleepTarget')?.value || 8);
    const wasScheduleEnabled = currentSettings().scheduleEnabled;
    const settings = {
      locationEnabled: Boolean(byId('nativeLocationEnabled')?.checked),
      scheduleEnabled: Boolean(byId('nativeLocationScheduleEnabled')?.checked),
      activityEnabled: Boolean(byId('nativeActivityEnabled')?.checked),
      gymEnabled: Boolean(byId('nativeGymEnabled')?.checked),
      sleepEnabled: Boolean(byId('nativeSleepEnabled')?.checked),
      sleepTargetHours: Number.isFinite(target) ? Math.max(4, Math.min(14, target)) : 8
    };
    if (byId('nativeLocationEnabled')) byId('nativeLocationEnabled').checked = settings.locationEnabled;
    saveIfChanged(TRACKER_SETTINGS_KEY, settings);
    try {
      native.setTrackingSettings(settings.locationEnabled, settings.activityEnabled,
        settings.gymEnabled, settings.sleepEnabled, settings.sleepTargetHours);
      native.setLocationScheduleEnabled(settings.scheduleEnabled);
      if (settings.scheduleEnabled && !wasScheduleEnabled
          && !state?.backgroundLocationGranted
          && typeof native.requestGymDetectionPermissions === 'function') {
        native.requestGymDetectionPermissions();
      }
      state = parseNativeState() || state;
      syncNativeData(state);
      render();
      if (settings.sleepEnabled && state?.usageAccessGranted) refreshSleep();
    } catch (error) {
      console.error('Could not save native tracking settings.', error);
    }
  }

  function bindSettings() {
    const container = byId('nativeTrackerSettings');
    if (!container || container.dataset.bound === 'true') return;
    container.dataset.bound = 'true';
    ['nativeLocationEnabled', 'nativeLocationScheduleEnabled',
      'nativeActivityEnabled', 'nativeGymEnabled', 'nativeSleepEnabled']
      .forEach((id) => byId(id)?.addEventListener('change', saveSettings));
  }

  function addPanel(parent, id, markup) {
    if (!parent || byId(id)) return;
    parent.insertAdjacentHTML('beforeend', markup);
  }

  function initializeMapLibrary() {
    if (window.L) return Promise.resolve();
    if (leafletPromise) return leafletPromise;
    leafletPromise = new Promise((resolve, reject) => {
      const css = document.createElement('link');
      css.rel = 'stylesheet';
      css.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
      document.head.appendChild(css);
      const script = document.createElement('script');
      script.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js';
      script.onload = () => resolve();
      script.onerror = () => reject(new Error('The map library could not be loaded. Check your internet connection.'));
      document.head.appendChild(script);
    });
    return leafletPromise;
  }

  async function openGymMap() {
    const wrap = byId('nativeGymMapWrap');
    if (!wrap) return;
    wrap.hidden = false;
    byId('nativeGymMapStatus').textContent = 'Loading map…';
    try {
      await initializeMapLibrary();
      mapInstance?.remove();
      mapMarker = null;
      mapCircle = null;
      selectedGym = null;
      const storedCandidate = validCoordinates(state?.gymLocation)
        ? state.gymLocation : readObject(GYM_KEY).location;
      const stored = validCoordinates(storedCandidate) ? storedCandidate : null;
      let gpsLocation = null;
      try {
        const current = native?.getCurrentLocation ? JSON.parse(native.getCurrentLocation()) : null;
        if (validCoordinates(current)) gpsLocation = current;
      } catch (error) {
        console.error('Could not read the current location for gym map centering.', error);
      }
      const centerLocation = gpsLocation || stored;
      if (gpsLocation && !stored) {
        byId('nativeGymLatitude').value = String(gpsLocation.latitude);
        byId('nativeGymLongitude').value = String(gpsLocation.longitude);
      }
      const center = centerLocation
        ? [Number(centerLocation.latitude), Number(centerLocation.longitude)] : [20, 0];
      mapInstance = window.L.map('nativeGymMap', { zoomControl: true })
        .setView(center, gpsLocation ? 15 : stored ? 16 : 2);
      window.L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors'
      }).addTo(mapInstance);
      if (stored) setMapSelection(Number(stored.latitude), Number(stored.longitude),
        Number(stored.radiusMeters) || 120, false);
      mapInstance.on('click', (event) => setMapSelection(event.latlng.lat, event.latlng.lng));
      byId('nativeGymRadius').value = String(selectedGym?.radiusMeters || 120);
      byId('nativeGymRadiusValue').textContent = `${byId('nativeGymRadius').value} m`;
      byId('nativeGymRadius').oninput = (event) => {
        if (selectedGym) {
          selectedGym.radiusMeters = Number(event.target.value);
          byId('nativeGymRadiusValue').textContent = `${event.target.value} m`;
          setMapSelection(selectedGym.latitude, selectedGym.longitude, selectedGym.radiusMeters, false);
        }
      };
      window.setTimeout(() => mapInstance?.invalidateSize(), 100);
      byId('nativeGymMapStatus').textContent = stored
        ? `Saved gym location ${Number(stored.latitude).toFixed(5)}, ${Number(stored.longitude).toFixed(5)}. Tap to change.`
        : gpsLocation
          ? 'Map centered on your current GPS location. Tap the gym to select a geofence center.'
          : 'Current GPS location is unavailable. Move the map to the gym and tap to select a geofence center.';
    } catch (error) {
      console.error('Could not open the gym map.', error);
      leafletPromise = null;
      byId('nativeGymMapStatus').textContent = `${error.message} Enter the gym coordinates below to save its geofence without the map.`;
    }
  }

  function setMapSelection(latitude, longitude, radiusMeters = 120, updateStatus = true) {
    if (!Number.isFinite(latitude) || latitude < -90 || latitude > 90
        || !Number.isFinite(longitude) || longitude < -180 || longitude > 180
        || !Number.isFinite(radiusMeters) || radiusMeters <= 0) {
      selectedGym = null;
      byId('nativeSaveGymLocation').disabled = true;
      if (updateStatus) byId('nativeGymMapStatus').textContent =
        'Choose a valid latitude and longitude before saving the geofence.';
      return;
    }
    selectedGym = { latitude, longitude, radiusMeters };
    if (byId('nativeGymLatitude')) byId('nativeGymLatitude').value = latitude.toFixed(6);
    if (byId('nativeGymLongitude')) byId('nativeGymLongitude').value = longitude.toFixed(6);
    if (window.L && mapInstance) {
      if (mapMarker) mapMarker.remove();
      mapMarker = window.L.marker([latitude, longitude]).addTo(mapInstance);
      if (mapCircle) mapCircle.remove();
      mapCircle = window.L.circle([latitude, longitude], { radius: radiusMeters, color: '#ff806f' }).addTo(mapInstance);
    }
    if (updateStatus) {
      byId('nativeGymMapStatus').textContent = `Selected ${latitude.toFixed(5)}, ${longitude.toFixed(5)} · ${Math.round(radiusMeters)} m geofence.`;
    }
    byId('nativeSaveGymLocation').disabled = false;
  }

  function saveGymLocation() {
    if (!native || !selectedGym || !validCoordinates(selectedGym)) {
      byId('nativeGymMapStatus').textContent =
        'Choose a valid latitude and longitude before saving the geofence.';
      return;
    }
    try {
      native.setGymLocation(selectedGym.latitude, selectedGym.longitude, selectedGym.radiusMeters);
      const gym = readObject(GYM_KEY);
      gym.location = selectedGym;
      saveIfChanged(GYM_KEY, gym);
      state = parseNativeState() || state;
      syncNativeData(state);
      render();
    } catch (error) {
      console.error('Could not save the gym geofence.', error);
      byId('nativeGymMapStatus').textContent = 'Could not save the gym geofence. Check Android storage and try again.';
    }
  }

  function refreshSleep() {
    if (!native || typeof native.refreshSleepEstimate !== 'function') return;
    try {
      const response = JSON.parse(native.refreshSleepEstimate());
      sleepAvailabilityStatus = response.status || 'unavailable';
      state = parseNativeState() || state;
      syncNativeData(state);
      render();
      const status = byId('nativeNightRecoveryStatus');
      if (response.status === 'permission_required') {
        if (status) status.textContent = 'Grant Android Usage Access to calculate foreground app use during last night’s window.';
      } else if (response.status === 'insufficient_data' || response.status === 'waiting_for_activity') {
        if (status) status.textContent = 'No completed 11:00 PM–6:30 AM phone-use sample is available yet.';
      } else if (response.status === 'unavailable') {
        if (status) status.textContent = `Android phone-use data could not be read: ${response.error || 'UsageStats is unavailable.'}`;
      }
    } catch (error) {
      console.error('Could not refresh the UsageStats sleep estimate.', error);
    }
  }

  function refresh() {
    const previousState = state;
    state = parseNativeState();
    applySyncedSettings(previousState);
    syncNativeData(state);
    render();
    bindSettings();
  }

  function applySyncedSettings(previousState) {
    if (!native || typeof native.syncTrackingSettings !== 'function' || !state) return;
    try {
      const raw = localStorage.getItem(TRACKER_SETTINGS_KEY);
      if (raw === null) return;
      const saved = JSON.parse(raw);
      if (!saved || typeof saved !== 'object' || Array.isArray(saved)) return;
      const settings = {
        locationEnabled: Boolean(saved.locationEnabled),
        activityEnabled: Boolean(saved.activityEnabled),
        gymEnabled: Boolean(saved.gymEnabled),
        sleepEnabled: Boolean(saved.sleepEnabled),
        sleepTargetHours: Number(saved.sleepTargetHours) || 8
      };
      const differs = !previousState
        || settings.locationEnabled !== state.locationEnabled
        || settings.activityEnabled !== state.activityEnabled
        || settings.gymEnabled !== state.gymEnabled
        || settings.sleepEnabled !== state.sleepEnabled
        || settings.sleepTargetHours !== Number(state.sleepTargetHours);
      if (differs) {
        native.syncTrackingSettings(settings.locationEnabled, settings.activityEnabled,
          settings.gymEnabled, settings.sleepEnabled, settings.sleepTargetHours);
      }
    } catch (error) {
      console.error('Could not apply synced tracking settings.', error);
    }
  }

  function initialize() {
    addPanel(byId('todayAppUsage'), 'nativeAppUsageCard', appUsageMarkup());
    addPanel(byId('todayCardioTracker'), 'nativeCardioCard', cardioMarkup());
    const gym = byId('gym');
    addPanel(gym, 'nativeGymCard', gymMarkup());
    byId('todayGymTracker')?.remove();
    const gymCard = byId('nativeGymCard');
    if (gym && gymCard && !byId('nativeGymDisclosure')) {
      const disclosure = document.createElement('details');
      disclosure.id = 'nativeGymDisclosure';
      disclosure.className = 'nativeGymDisclosure';
      const summary = document.createElement('summary');
      summary.id = 'nativeGymDisclosureSummary';
      disclosure.appendChild(summary);
      disclosure.appendChild(gymCard);
      gym.insertBefore(disclosure, gym.querySelector('.gymTabs') || gym.firstChild);
    }
    const settings = document.querySelector('#settings .settingsPanel');
    addPanel(settings, 'nativeTrackerSettings', settingsMarkup());
    addPanel(byId('todayNightRecovery'), 'nativeSleepCard', sleepMarkup());
    refresh();
    bindSettings();
    loadLocationHistoryYear(locationHistoryYear);
    refreshAppUsage();
    window.addEventListener('blink:native-update', refresh);
    window.addEventListener('blink:native-resume', () => {
      refresh();
      refreshAppUsage();
      if (state?.sleepEnabled && state?.usageAccessGranted) refreshSleep();
    });
    document.addEventListener('visibilitychange', () => {
      if (!document.hidden) refreshAppUsage();
    });
    window.addEventListener('storage', (event) => {
      if ([CARDIO_KEY, GYM_KEY, SLEEP_KEY, STEPS_KEY, TRACKER_SETTINGS_KEY,
        WORKOUT_HISTORY_KEY, WELLNESS_LOGS_KEY].includes(event.key)) {
        if (event.key === GYM_KEY) {
          const location = readObject(GYM_KEY).location;
          if (validCoordinates(location) && state?.gymLocation
              && (Number(location.latitude) !== Number(state.gymLocation.latitude)
                || Number(location.longitude) !== Number(state.gymLocation.longitude))
              && native?.setGymLocation) {
            native.setGymLocation(Number(location.latitude), Number(location.longitude),
              Number(location.radiusMeters) || 120);
          }
        }
        refresh();
      }
    });
    window.BlinkAppState.subscribe((_sharedState, key, source) => {
      if (source === 'external' && [CARDIO_KEY, GYM_KEY, SLEEP_KEY, STEPS_KEY,
        TRACKER_SETTINGS_KEY, WORKOUT_HISTORY_KEY, WELLNESS_LOGS_KEY].includes(key)) refresh();
    });
    window.setInterval(refresh, 5_000);
    window.setInterval(() => {
      if (state?.sleepEnabled && state?.usageAccessGranted) refreshSleep();
    }, 60 * 60 * 1000);
    window.setInterval(() => {
      if (!document.hidden) refreshAppUsage();
    }, 5 * 60 * 1000);
    if (state?.sleepEnabled && state?.usageAccessGranted) refreshSleep();
  }

  window.BlinkTodayTracking = { refreshAppUsage };
  initialize();
})();
