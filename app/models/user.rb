# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :reading_tasks, dependent: :destroy
  has_many :task_categories, dependent: :destroy

  has_many :lendings_given, class_name: "Lending",    foreign_key: :lender_id
  has_many :lendings_received, class_name: "Lending", foreign_key: :borrower_id
  has_many :reviews, dependent: :destroy

  # only require a username on create; enforce uniqueness always
  validates :username, presence: true, on: :create
  validates :username, uniqueness: true

  before_validation :assign_username, on: :create
  before_destroy    :prevent_super_admin_deletion

  def super_admin?
    email == ApplicationHelper::SUPER_ADMIN_EMAIL
  end

  private

  def prevent_super_admin_deletion
    if super_admin?
      errors.add(:base, "Cannot delete the super-admin account")
      throw :abort
    end
  end

  def assign_username
    return if username.present?
    base = "#{first_name[0].downcase}.#{last_name.downcase}_"
    loop do
      suffix    = rand.to_s[2..6]
      generated = "#{base}#{suffix}"
      unless User.exists?(username: generated)
        self.username = generated
        break
      end
    end
  end
end

