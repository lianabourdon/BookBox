class AddCompletedAtAndRecommendedToReadingTasks < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:reading_tasks, :completed_at)
      add_column :reading_tasks, :completed_at, :datetime
    end

    unless column_exists?(:reading_tasks, :recommended)
      add_column :reading_tasks, :recommended, :boolean, default: false, null: false
    end
  end
end

