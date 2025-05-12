# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class AddUserToBooks < ActiveRecord::Migration[7.0]
  SUPER_ADMIN_EMAIL = 'admin@example.com'.freeze

  def up
    # 1) add the reference, allow nulls for now
    add_reference :books, :user, foreign_key: true, null: true

    # 2) backfill existing books to super-admin
    say_with_time "Assigning all existing books to #{SUPER_ADMIN_EMAIL}" do
      super_admin = User.find_by(email: SUPER_ADMIN_EMAIL)
      raise "Super-admin (#{SUPER_ADMIN_EMAIL}) must exist before migrating books!" unless super_admin

      Book.reset_column_information
      Book.update_all(user_id: super_admin.id)
    end

    # 3) now enforce NOT NULL
    change_column_null :books, :user_id, false
  end

  def down
    remove_reference :books, :user, foreign_key: true
  end
end

