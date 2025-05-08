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

