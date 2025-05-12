# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/models/book.rb
class Book < ApplicationRecord
  # ──────────────── Associations ──────────────────────────────────────────
  belongs_to :user
  belongs_to :genre

  has_many :reading_tasks, dependent: :destroy
  has_many :reviews,       dependent: :destroy

  # Active-Storage
  has_one_attached :cover

  # Lending relations
  has_one  :active_lending,
           -> { where(returned_at: nil) },
           class_name: "Lending",
           dependent:  :destroy
  has_many :lendings, dependent: :destroy

  # ──────────────── Virtual attr for purging the cover ────────────────────
  # The form sends "remove_cover=1" when the user ticks the checkbox.
  attr_accessor :remove_cover
  before_save   :purge_cover_if_requested

  # ──────────────── Validations ───────────────────────────────────────────
  validates :title,  :author, :genre_id, presence: true
  validates :published_year,
            numericality: { only_integer: true, greater_than: 0 },
            allow_nil:    true

  validate  :acceptable_cover            # size / mime-type guard

  # ──────────────── Convenience helpers ───────────────────────────────────
  def loaned_out? = active_lending.present?
  def loaned_to   = active_lending&.borrower
  def loaned_by   = active_lending&.lender
  def summary     = description

  private

  # Remove the attachment **before** the record is saved when the flag is set
  def purge_cover_if_requested
    cover.purge if ActiveModel::Type::Boolean.new.cast(remove_cover)
  end

  # Reject huge or non-image uploads
  def acceptable_cover
    return unless cover.attached?

    unless cover.content_type&.start_with?("image/")
      errors.add :cover, "must be an image file (PNG, JPG, or WEBP)"
    end

    if cover.byte_size > 5.megabytes
      errors.add :cover, "is too large (maximum 5 MB)"
    end
  end
end

