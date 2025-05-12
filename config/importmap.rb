# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# config/importmap.rb
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@rails/ujs",          to: "@rails--ujs.js"
pin "application", preload: true
pin "@hotwired/stimulus", to: "https://unpkg.com/@hotwired/stimulus@3.2.2/dist/stimulus.umd.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
