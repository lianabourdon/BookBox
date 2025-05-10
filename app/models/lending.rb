# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class Lending < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :borrower, class_name: 'User'
  belongs_to :book

  # ✅ Only enforce uniqueness of a loan if it's active (returned_at is nil)
  validates :book_id, uniqueness: {
    scope: :returned_at,
    message: "is already on loan",
    conditions: -> { where(returned_at: nil) }
  }
end

