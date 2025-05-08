class AddUniqueIndexToTaskCategoriesNameUser < ActiveRecord::Migration[7.2]
  def change
    # prevents two categories with same name for same user
    add_index :task_categories,
              [:name, :user_id],
              unique: true,
              name: "index_task_categories_on_name_and_user"
  end
end

