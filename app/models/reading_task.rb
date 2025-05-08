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

