// ---------------------------------------------------------------------------
// BookBox – COM214 Final Project (Spring 2025)
// Author contributions:
//   Cam Nguyen      – dark_toggle_controller, select2_controller
//   Liana Bourdon   – reading_task_controller
//   Annabelle Duval – flash_dismiss.js
// ---------------------------------------------------------------------------

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
