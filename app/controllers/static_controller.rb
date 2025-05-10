# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class StaticController < ApplicationController
  # Add :faq to the skip list so guests can view it
  skip_before_action :authenticate_user!, only: %i[home credits faq]

  def home; end
  def credits; end
  def faq; end         # ← make sure this action exists
end

