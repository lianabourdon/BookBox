class RemoveDescriptionFromReadingTasks < ActiveRecord::Migration[7.2]
  def change
    if column_exists?(:reading_tasks, :description)
      remove_column :reading_tasks, :description, :text
    end
  end
end

