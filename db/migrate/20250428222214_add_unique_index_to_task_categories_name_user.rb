# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class AddUniqueIndexToTaskCategoriesNameUser < ActiveRecord::Migration[7.2]
  def change
    # prevents two categories with same name for same user
    add_index :task_categories,
              [:name, :user_id],
              unique: true,
              name: "index_task_categories_on_name_and_user"
  end
end

