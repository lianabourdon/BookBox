# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :genre, null: false
      t.integer :published_year
      t.text :description

      t.timestamps
    end
  end
end
