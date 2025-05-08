class AddColorToTaskCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :task_categories, :color, :string
  end
end

