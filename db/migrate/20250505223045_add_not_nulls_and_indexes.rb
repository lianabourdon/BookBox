# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# db/migrate/20250505223045_add_not_nulls_and_indexes.rb
class AddNotNullsAndIndexes < ActiveRecord::Migration[7.2]
  # ⬇️ stub model so we can run update_all in change
  class ReadingTask < ActiveRecord::Base; end

  def change
    # 1️⃣ NOT-NULL constraints ------------------------------------
    change_column_null :books,         :title,  false
    change_column_null :books,         :author, false

    # any legacy ReadingTask rows with NULL title → “Untitled”
    ReadingTask.where(title: nil).update_all(title: "Untitled")
    change_column_null :reading_tasks, :title,  false

    change_column_null :reviews,       :rating, false

    # 2️⃣ Indexes (only if missing) -------------------------------
    add_index :books,         :user_id                       unless index_exists?(:books,         :user_id)
    add_index :reading_tasks, :user_id                       unless index_exists?(:reading_tasks, :user_id)
    add_index :reading_tasks, :book_id                       unless index_exists?(:reading_tasks, :book_id)
    add_index :reviews,       [:user_id, :book_id], unique: true unless index_exists?(:reviews, [:user_id, :book_id])
  end
end

