# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class CreateTaskCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :task_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
