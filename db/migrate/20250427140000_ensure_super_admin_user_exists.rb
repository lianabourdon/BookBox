# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class EnsureSuperAdminUserExists < ActiveRecord::Migration[7.0]
  def up
    User.create!(email: 'admin@example.com', password: 'steelers', admin: true) unless User.exists?(email: 'admin@example.com')
  end

  def down
    User.find_by(email: 'admin@example.com')&.destroy
  end
end

