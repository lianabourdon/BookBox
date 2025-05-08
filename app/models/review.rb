# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # ───────────────────────── Validations ──────────────────────────
  validates :rating,
            presence: true,
            numericality: { only_integer: true,
                            greater_than: 0,
                            less_than_or_equal_to: 5 }

  validates :comment,
            presence: true,
            length:  { minimum: 5, maximum: 1_000 }

  # one review per user per book (model- and DB-level)
  validates :user_id,
            uniqueness: { scope: :book_id,
                          message: "has already reviewed this book" }
end

