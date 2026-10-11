(() => {
  'use strict';

  const keys = new Set([
    'blinkCal',
    'blinkNotifications',
    'blinkWorkoutLogs',
    'blinkWorkoutsByDay',
    'blinkTodayExercises',
    'blinkWellnessLogs',
    'blinkFuelDailyHistory',
    'blinkWorkoutDailyHistory',
    'blinkCollegeSchedules',
    'blinkSleepEstimates',
    'blinkCardioLogs',
    'blinkCardioSessions',
    'blinkGymSessions',
    'blinkStepHistory',
    'blinkMind',
    'blinkFoods',
    'blinkTrackerSettings',
    'blinkBudget',
    'blinkPersonalProfile'
  ]);

  function read(key, fallback = null) {
    try {
      const saved = localStorage.getItem(key);
      if (saved === null) return fallback;
      return JSON.parse(saved);
    } catch (error) {
      console.error(`Could not read shared app state "${key}".`, error);
      return fallback;
    }
  }

  function snapshot() {
    return {
      calendar: read('blinkCal', {}),
      notifications: read('blinkNotifications', null),
      training: {
        logs: read('blinkWorkoutLogs', {}),
        plans: read('blinkWorkoutsByDay', {}),
        legacyPlan: read('blinkTodayExercises', null)
      },
      recovery: {
        entries: read('blinkWellnessLogs', []),
        sleep: read('blinkSleepEstimates', { estimates: [] }),
        cardio: read('blinkCardioSessions', { sessions: [] }),
        nativeCardio: read('blinkCardioSessions', { sessions: [] }),
        gym: read('blinkGymSessions', { sessions: [] }),
        steps: read('blinkStepHistory', { days: {} }),
        mindfulness: read('blinkMind', {}),
        foods: read('blinkFoods', {})
      },
      spending: read('blinkBudget', []),
      settings: {
        tracking: read('blinkTrackerSettings', {})
      },
      profile: {
        details: read('blinkPersonalProfile', {})
      }
    };
  }

  function publish(key, source = 'local') {
    window.dispatchEvent(new CustomEvent('blink:shared-state-change', {
      detail: { key, source, state: snapshot() }
    }));
  }

  const originalSetItem = Storage.prototype.setItem;
  Storage.prototype.setItem = function (key, value) {
    originalSetItem.call(this, key, value);
    if (this === window.localStorage && keys.has(String(key))) publish(String(key));
  };

  const originalRemoveItem = Storage.prototype.removeItem;
  Storage.prototype.removeItem = function (key) {
    originalRemoveItem.call(this, key);
    if (this === window.localStorage && keys.has(String(key))) publish(String(key));
  };

  const originalClear = Storage.prototype.clear;
  Storage.prototype.clear = function () {
    originalClear.call(this);
    if (this === window.localStorage) publish(null);
  };

  window.addEventListener('storage', (event) => {
    if (event.key === null || keys.has(event.key)) publish(event.key, 'external');
  });

  window.BlinkAppState = Object.freeze({
    read,
    snapshot,
    write(key, value) {
      localStorage.setItem(key, JSON.stringify(value));
    },
    subscribe(listener) {
      const handler = (event) => listener(event.detail.state, event.detail.key, event.detail.source);
      window.addEventListener('blink:shared-state-change', handler);
      return () => window.removeEventListener('blink:shared-state-change', handler);
    }
  });
})();
