# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class CreateLendings < ActiveRecord::Migration[7.2]
  def change
    create_table :lendings do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.integer :book_id
      t.datetime :loaned_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
