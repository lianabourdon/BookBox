# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# db/migrate/20250428222212_add_unique_index_to_task_categories.rb
class AddUniqueIndexToTaskCategories < ActiveRecord::Migration[7.0]
  def change
    add_index :task_categories,
              %i[user_id name],
              unique: true,
              name: "index_task_categories_on_user_id_and_name"
  end
end

