(() => {
  'use strict';

  const scrollStylesheet = document.createElement('link');
  scrollStylesheet.rel = 'stylesheet';
  scrollStylesheet.href = 'blink-scroll-map.css';
  document.head.appendChild(scrollStylesheet);

  window.toggle = (index) => {
    const row = document.getElementById(`food${index}`);
    if (!row) return;
    const button = row.querySelector('.row2 .remove');
    const expanded = !row.classList.contains('expanded');
    row.classList.toggle('expanded', expanded);
    if (button) {
      button.setAttribute('aria-expanded', String(expanded));
      button.textContent = expanded ? 'Hide facts' : 'Nutrition';
    }
    if (expanded) row.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
  };

  document.body.style.removeProperty('overflow');

  const scrollContainer = document.querySelector('.phone');
  if (scrollContainer) {
    scrollContainer.style.setProperty('height', '100vh', 'important');
    scrollContainer.style.setProperty('height', '100dvh', 'important');
    scrollContainer.style.setProperty('min-height', '0', 'important');
    scrollContainer.style.setProperty('max-height', '100dvh', 'important');
    scrollContainer.style.setProperty('overflow-x', 'hidden', 'important');
    scrollContainer.style.setProperty('overflow-y', 'auto', 'important');
    scrollContainer.style.setProperty('-webkit-overflow-scrolling', 'touch');
    scrollContainer.style.setProperty('touch-action', 'pan-y', 'important');
  }
  const originalTab = window.tab;
  if (scrollContainer && typeof originalTab === 'function' && !originalTab.blinkScrollWrapped) {
    const tabWithScrollReset = function (...args) {
      const result = originalTab.apply(this, args);
      window.requestAnimationFrame(() => scrollContainer.scrollTo({ top: 0, left: 0, behavior: 'auto' }));
      return result;
    };
    tabWithScrollReset.blinkScrollWrapped = true;
    window.tab = tabWithScrollReset;
  }
})();
