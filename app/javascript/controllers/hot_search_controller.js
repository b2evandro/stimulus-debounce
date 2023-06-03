import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="hot-search"
export default class extends Controller {
  connect() {
    this.debouncedSearch = debounce(this.debouncedSearch.bind(this), 500);
  }

  debouncedSearch() {
    this.element.requestSubmit();
  }
}

function debounce(callback, delay) {
  let timeoutId;
  return (...args) => {
    if (timeoutId) {
      clearTimeout(timeoutId);
    }
    timeoutId = setTimeout(() => {
      callback(...args);
      timeoutId = null;
    }, delay);
  };
}
