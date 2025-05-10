# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  # don’t require login to see the landing page
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end
end

