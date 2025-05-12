# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :books, dependent: :destroy
  has_many :reading_tasks, dependent: :destroy
  has_many :task_categories, dependent: :destroy

  has_many :lendings_given, class_name: "Lending",    foreign_key: :lender_id
  has_many :lendings_received, class_name: "Lending", foreign_key: :borrower_id
  has_many :reviews, dependent: :destroy

  # Virtual attribute for authenticating by either username or email
  attr_writer :login

  # Username validations
  validates :username, presence: true, on: :create
  validates :username, uniqueness: true

  before_validation :assign_username, on: :create
  before_destroy    :prevent_super_admin_deletion

  # Authenticate using either username or email
  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(
        ["lower(username) = :value OR lower(email) = :value",
        { value: login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end

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

