# db/migrate/20250428222212_add_unique_index_to_task_categories.rb
class AddUniqueIndexToTaskCategories < ActiveRecord::Migration[7.0]
  def change
    add_index :task_categories,
              %i[user_id name],
              unique: true,
              name: "index_task_categories_on_user_id_and_name"
  end
end

