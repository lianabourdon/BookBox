import '@hotwired/turbo-rails';
import Rails from "@rails/ujs"
window.Rails = Rails
Rails.start()

let application;
if (window.Stimulus && window.Stimulus.Application) {
  application = window.Stimulus.Application.start();
  window.application = application;
} else {
  console.error("Stimulus not loaded correctly.");
}

import "controllers"
