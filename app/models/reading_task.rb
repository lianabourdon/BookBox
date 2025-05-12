# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/models/reading_task.rb
class ReadingTask < ApplicationRecord
  # ────────────────────────── Enum ────────────────────────────────
  enum priority: { high: 1, medium: 2, low: 3 }

  # ─────────────────────── Associations ───────────────────────────
  belongs_to :book
  belongs_to :user
  belongs_to :task_category

  # ───────────────────────── Validations ──────────────────────────
  validates :title,
            presence: true,
            length:  { maximum: 120 }

  validates :priority,      presence: true
  validates :task_category, presence: true

  # recommended flag is a simple boolean (no extra validation needed)

  # ─────────────────────── Instance helpers ───────────────────────
  def mark_completed!
    update!(completed: true)
  end
end

