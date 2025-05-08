class AddTitleToReadingTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :reading_tasks, :title, :string
  end
end

