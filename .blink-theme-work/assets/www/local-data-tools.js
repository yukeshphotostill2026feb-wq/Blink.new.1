(() => {
  'use strict';

  const BACKUP_FORMAT = 'BLINK_LOCAL_BACKUP';
  const FUEL_HISTORY_KEY = 'blinkFuelDailyHistory';
  const WORKOUT_HISTORY_KEY = 'blinkWorkoutDailyHistory';
  const DATA_PREFIX = 'blink';
  let restoring = false;
  const dateKey = (date = new Date()) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };
  const validDate = (value) => /^\d{4}-\d{2}-\d{2}$/.test(value)
    && !Number.isNaN(new Date(`${value}T00:00:00`).getTime());
  const sections = {
    'User profile': ['blinkProfileName', 'blinkPersonalProfile', 'blinkNutritionProfile'],
    'Workout data': ['blinkWorkoutLogs', 'blinkWorkoutsByDay', 'blinkTodayExercises', WORKOUT_HISTORY_KEY],
    'Diet/Fuel data': ['blinkFoods', 'blinkDietHistory', FUEL_HISTORY_KEY],
    'Route data': ['blinkCal', 'blinkCollegeSchedules', 'blinkCardioLogs', 'blinkCardioSessions', 'blinkGymSessions', 'blinkStepHistory'],
    'Sleep/recovery data': ['blinkWellnessLogs', 'blinkSleepEstimates', 'blinkMind'],
    'Spending data': ['blinkBudget'],
    Settings: ['blinkUserSettings', 'blink-settings', 'blinkTrackerSettings', 'blinkNotifications', 'blinkNotchPrefs'],
    'College schedule': ['blinkCollegeSchedules', 'blinkCollegeAttendance', 'blinkCollegeReminderSettings']
  };
  const byId = (id) => document.getElementById(id);

  function setBackupStatus(message, isError = false) {
    const status = byId('localDataBackupStatus');
    if (!status) return;
    status.textContent = message;
    status.classList.toggle('error', isError);
  }

  function readHistory(key, validate) {
    const raw = localStorage.getItem(key);
    if (raw === null) return [];
    const value = JSON.parse(raw);
    if (!Array.isArray(value) || !value.every(validate)) {
      throw new Error(`Saved ${key} has an unexpected format; existing data was left untouched.`);
    }
    return value;
  }

  function saveDailyFuel() {
    if (typeof items === 'undefined' || typeof DB === 'undefined' || typeof nutrient !== 'function') return;
    const foods = items.filter((item) => item && DB[item.key]);
    const entry = {
      date: dateKey(),
      calories: foods.reduce((sum, item) => sum + (Number(nutrient(item, 'kcal')) || 0), 0),
      proteinGrams: foods.reduce((sum, item) => sum + (Number(nutrient(item, 'protein')) || 0), 0),
      foodCount: foods.length
    };
    const previous = readHistory(FUEL_HISTORY_KEY, (row) =>
      row && validDate(row.date) && Number.isFinite(row.calories) && row.calories >= 0
        && Number.isFinite(row.proteinGrams) && row.proteinGrams >= 0
        && Number.isInteger(row.foodCount) && row.foodCount >= 0);
    const byDate = new Map(previous.map((row) => [row.date, row]));
    byDate.set(entry.date, entry);
    localStorage.setItem(FUEL_HISTORY_KEY, JSON.stringify([...byDate.values()]));
  }

  function saveDailyWorkoutCompletions() {
    const raw = localStorage.getItem('blinkWorkoutLogs');
    const logs = raw === null ? {} : JSON.parse(raw);
    if (!logs || typeof logs !== 'object' || Array.isArray(logs)) {
      throw new Error('Saved workout logs have an unexpected format; existing data was left untouched.');
    }
    const completed = new Map();
    Object.entries(logs).forEach(([id, log]) => {
      if (!log?.done || !validDate(log.completedOn)) return;
      if (!completed.has(log.completedOn)) completed.set(log.completedOn, new Set());
      completed.get(log.completedOn).add(id);
    });
    if (!completed.size) return;
    const previous = readHistory(WORKOUT_HISTORY_KEY, (row) =>
      row && validDate(row.date) && Array.isArray(row.exerciseIds)
        && row.exerciseIds.every((id) => typeof id === 'string'));
    const byDate = new Map(previous.map((row) => [row.date, new Set(row.exerciseIds)]));
    completed.forEach((ids, date) => {
      const savedIds = byDate.get(date) || new Set();
      ids.forEach((id) => savedIds.add(id));
      byDate.set(date, savedIds);
    });
    const history = [...byDate.entries()]
      .map(([date, exerciseIds]) => ({ date, exerciseIds: [...exerciseIds] }))
      .sort((left, right) => left.date.localeCompare(right.date));
    localStorage.setItem(WORKOUT_HISTORY_KEY, JSON.stringify(history));
  }

  function recordDailyHistory() {
    const errors = [];
    [
      ['fuel', saveDailyFuel],
      ['workout', saveDailyWorkoutCompletions]
    ].forEach(([label, save]) => {
      try {
        save();
      } catch (error) {
        console.error(`Could not save daily ${label} history; existing history was left untouched.`, error);
        errors.push(label);
      }
    });
    if (errors.length) {
      setBackupStatus(`Could not save daily ${errors.join(' and ')} history locally. Existing history was left untouched.`, true);
    }
  }

  function localData() {
    const data = {};
    for (let index = 0; index < localStorage.length; index += 1) {
      const key = localStorage.key(index);
      if (key?.startsWith(DATA_PREFIX)) data[key] = localStorage.getItem(key);
    }
    return data;
  }

  function backupPayload(data) {
    const keys = Object.keys(data);
    const included = new Set(Object.values(sections).flat());
    const contents = Object.fromEntries(Object.entries(sections)
      .map(([name, sectionKeys]) => [name, sectionKeys.filter((key) => keys.includes(key))]));
    contents['Other app data'] = keys.filter((key) => !included.has(key));
    return {
      format: BACKUP_FORMAT,
      formatVersion: 1,
      exportedAt: new Date().toISOString(),
      sections: contents,
      data
    };
  }

  function downloadBackup() {
    const native = window.BlinkNative;
    try {
      const payload = JSON.stringify(backupPayload(localData()), null, 2);
      if (typeof native?.saveScheduleBackup === 'function') {
        native.saveScheduleBackup('blink-local-backup.json', payload);
        setBackupStatus('Choose where to save your complete BLINK backup.');
        return;
      }
      const url = URL.createObjectURL(new Blob([payload], { type: 'application/json' }));
      const link = document.createElement('a');
      link.href = url;
      link.download = 'blink-local-backup.json';
      link.click();
      window.setTimeout(() => URL.revokeObjectURL(url), 1000);
      setBackupStatus('Complete BLINK backup downloaded to this device.');
    } catch (error) {
      console.error('Could not download the local data backup.', error);
      setBackupStatus('Could not download the backup. Check device storage and try again.', true);
    }
  }

  function validateBackup(parsed) {
    if (!parsed || typeof parsed !== 'object' || Array.isArray(parsed)
        || parsed.format !== BACKUP_FORMAT || parsed.formatVersion !== 1
        || !parsed.data || typeof parsed.data !== 'object' || Array.isArray(parsed.data)) {
      throw new Error('This is not a supported BLINK data backup.');
    }
    const entries = Object.entries(parsed.data);
    if (entries.some(([key, value]) =>
      !/^blink[A-Za-z0-9:_-]*$/.test(key) || typeof value !== 'string')) {
      throw new Error('This backup contains unsupported app data; nothing was changed.');
    }
    return entries;
  }

  function syncNativeTracking(entries) {
    const native = window.BlinkNative;
    if (!native) return;
    const importedKeys = new Set(entries.map(([key]) => key));
    const readSaved = (key, fallback) => {
      const raw = localStorage.getItem(key);
      return raw === null ? fallback : JSON.parse(raw);
    };
    if (typeof native.syncTrackingSettings === 'function' && importedKeys.has('blinkTrackerSettings')) {
      const settings = readSaved('blinkTrackerSettings', {});
      native.syncTrackingSettings(
        Boolean(settings.locationEnabled),
        Boolean(settings.activityEnabled),
        Boolean(settings.gymEnabled),
        Boolean(settings.sleepEnabled),
        Number(settings.sleepTargetHours) || 8
      );
    }
    if (typeof native.syncTrackingRecords === 'function'
        && ['blinkCardioSessions', 'blinkGymSessions', 'blinkSleepEstimates'].some((key) => importedKeys.has(key))) {
      native.syncTrackingRecords(
        JSON.stringify(readSaved('blinkCardioSessions', { sessions: [] })),
        JSON.stringify(readSaved('blinkGymSessions', { sessions: [] })),
        JSON.stringify(readSaved('blinkSleepEstimates', { estimates: [] }))
      );
    }
  }

  function importBackup(file) {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      let entries;
      try {
        entries = validateBackup(JSON.parse(String(reader.result || '')));
      } catch (error) {
        console.error('Could not read the selected BLINK backup.', error);
        setBackupStatus(error instanceof Error ? error.message : 'Could not read this backup file.', true);
        return;
      }
      if (!window.confirm('Restore this backup? Matching BLINK data on this device will be replaced. Download a backup first if you want to keep a copy.')) {
        setBackupStatus('Restore cancelled. Your saved data was not changed.');
        return;
      }

      const originalValues = new Map(entries.map(([key]) => [key, localStorage.getItem(key)]));
      restoring = true;
      try {
        entries.forEach(([key, value]) => localStorage.setItem(key, value));
      } catch (error) {
        let rollbackFailed = false;
        originalValues.forEach((value, key) => {
          try {
            if (value === null) localStorage.removeItem(key);
            else localStorage.setItem(key, value);
          } catch (rollbackError) {
            rollbackFailed = true;
            console.error(`Could not restore the original value for ${key}.`, rollbackError);
          }
        });
        console.error('Could not restore the complete local data backup.', error);
        setBackupStatus(rollbackFailed
          ? 'Restore failed and some original values could not be recovered. Check device storage.'
          : 'Restore failed. Your previous data was kept.', true);
        return;
      } finally {
        restoring = false;
      }

      try {
        syncNativeTracking(entries);
      } catch (error) {
        console.error('Backup was saved locally, but Android tracking could not be updated.', error);
        setBackupStatus('Backup restored locally, but Android tracking could not be updated.', true);
        return;
      }
      window.BlinkCollegeScheduleManager?.refresh();
      setBackupStatus(`Restored ${entries.length} local data items. Existing data without a matching backup item was kept.`);
      window.setTimeout(() => window.location.reload(), 1500);
    };
    reader.onerror = () => setBackupStatus('Could not read the selected backup file.', true);
    reader.readAsText(file);
  }

  byId('downloadAllData')?.addEventListener('click', downloadBackup);
  byId('uploadAllData')?.addEventListener('click', () => byId('allDataImportInput')?.click());
  byId('allDataImportInput')?.addEventListener('change', (event) => {
    importBackup(event.target.files?.[0]);
    event.target.value = '';
  });

  const scheduleManager = window.BlinkCollegeScheduleManager;
  if (typeof scheduleManager?.onBackupResult === 'function') {
    const handleScheduleBackupResult = scheduleManager.onBackupResult;
    scheduleManager.onBackupResult = (success, message) => {
      handleScheduleBackupResult(success, message);
      setBackupStatus(message || (success ? 'Backup saved on this device.' : 'Could not save the backup.'), !success);
    };
  }

  window.BlinkAppState?.subscribe((_state, key) => {
    if (!restoring && (key === 'blinkWorkoutLogs' || key === 'blinkFoods')) recordDailyHistory();
  });
  document.addEventListener('change', (event) => {
    if (event.target?.closest('#diet')) recordDailyHistory();
  });

  recordDailyHistory();
})();
