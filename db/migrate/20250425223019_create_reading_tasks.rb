# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class CreateReadingTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :reading_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.references :task_category, null: false, foreign_key: true
      t.integer :priority
      t.boolean :completed

      t.timestamps
    end
  end
end
