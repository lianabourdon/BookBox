# app/models/task_category.rb
class TaskCategory < ApplicationRecord
  belongs_to :user

  # Prevent deleting if any reading_tasks still exist
  has_many :reading_tasks, dependent: :restrict_with_error

  validates :name,
            presence: true,
            uniqueness: {
              scope: :user_id,
              case_sensitive: false
            }

  # New: prevent a regular user from re-using a global (super-admin) category name
  validate :name_not_reserved_by_global, on: :create

  before_create :assign_color

  COLORS = %w[
    primary secondary success danger warning info dark
    orange teal purple pink cyan indigo
  ].freeze

  # only the current_user’s categories + super-admin’s
  def self.visible_for(user)
    super_admin = User.find_by(email: ApplicationHelper::SUPER_ADMIN_EMAIL)
    ids = [user.id]
    ids << super_admin.id if super_admin
    where(user_id: ids).order(:name)
  end

  private

  def name_not_reserved_by_global
    super_admin = User.find_by(email: ApplicationHelper::SUPER_ADMIN_EMAIL)
    return if super_admin.nil? || user_id == super_admin.id

    if TaskCategory.exists?(user_id: super_admin.id, name: name)
      errors.add(:name, "'#{name}' is reserved by the administrator")
    end
  end

  def assign_color
    self.color ||= COLORS.sample
  end
end

