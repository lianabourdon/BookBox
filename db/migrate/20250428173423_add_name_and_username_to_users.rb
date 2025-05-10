# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Nguyen      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Duval – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class AddNameAndUsernameToUsers < ActiveRecord::Migration[7.0]
  def up
    # 1) Add the new columns
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name,  :string, null: false, default: ""
    add_column :users, :username,   :string, null: false, default: ""

    # 2) Backfill every existing user’s `username` from their email prefix
    #    (split_part(email, '@', 1) gives the bit before the @)
    execute <<-SQL.squish
      UPDATE users
      SET username = split_part(email, '@', 1)
      WHERE username = '';
    SQL

    # 3) Now that no two rows share the empty string,
    #    we can add the unique index safely.
    add_index :users, :username, unique: true, name: "index_users_on_username"
  end

  def down
    remove_index  :users, name: "index_users_on_username"
    remove_column :users, :username
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end

