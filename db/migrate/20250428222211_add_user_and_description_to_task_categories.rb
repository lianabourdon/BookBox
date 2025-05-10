# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# db/migrate/20250428222211_add_user_and_description_to_task_categories.rb
class AddUserAndDescriptionToTaskCategories < ActiveRecord::Migration[7.0]
  def up
    # 1) add user reference
    add_reference :task_categories, :user, foreign_key: true

    # 2) add description column
    add_column :task_categories, :description, :text, null: false, default: ""

    # 3) backfill existing categories to the first admin user
    execute <<-SQL.squish
      UPDATE task_categories
      SET user_id = (
        SELECT id FROM users WHERE admin = true ORDER BY id LIMIT 1
      )
      WHERE user_id IS NULL;
    SQL

    # 4) now make user_id non-nullable
    change_column_null :task_categories, :user_id, false
  end

  def down
    remove_column    :task_categories, :description
    remove_reference :task_categories, :user, foreign_key: true
  end
end

