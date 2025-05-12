# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# db/migrate/20250428190000_add_trackable_to_users.rb
class AddTrackableToUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :users, bulk: true do |t|
      # Devise-trackable fields
      t.integer  :sign_in_count,      default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip  
      t.inet     :last_sign_in_ip    
    end
  end
end

