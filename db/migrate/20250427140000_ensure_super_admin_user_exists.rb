class EnsureSuperAdminUserExists < ActiveRecord::Migration[7.0]
  def up
    User.create!(email: 'admin@example.com', password: 'steelers', admin: true) unless User.exists?(email: 'admin@example.com')
  end

  def down
    User.find_by(email: 'admin@example.com')&.destroy
  end
end

