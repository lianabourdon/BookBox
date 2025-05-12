# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# frozen_string_literal: true

# -----------------------------------------------------------------------------
#  A tiny wrapper that lets us keep per–request global values (e.g. Current.user)
#  without resorting to thread-locals or class variables.
# -----------------------------------------------------------------------------
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end

