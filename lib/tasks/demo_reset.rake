# lib/tasks/demo_reset.rake
namespace :demo do
  desc "Reset all user-generated content but preserve default seeds"
  task reset: :environment do
    super_admin = User.find_by(email: 'admin@example.com')
    raise "Admin not found" unless super_admin

    puts "🔁 Deleting non-admin users and their data..."

    # Delete all users except the super_admin
    User.where.not(id: super_admin.id).find_each do |user|
      puts "🧹 Deleting data for #{user.email}"
      user.reading_tasks.destroy_all
      user.reviews.destroy_all if user.respond_to?(:reviews)
      user.books.destroy_all if user.respond_to?(:books)
      user.destroy
    end

    puts "✅ Reset complete. Only admin and default data remains."
  end
end

