# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# db/seeds.rb

# 1️⃣ Super-admin user
admin = User.find_or_initialize_by(email: 'admin@example.com')
admin.password              = 'steelers'
admin.password_confirmation = 'steelers'
admin.first_name            = 'Super'
admin.last_name             = 'Admin'
admin.admin                 = true
admin.save!

puts "✅ Super-admin created: #{admin.email} / password: steelers"

# 2️⃣ Genres (shared)
puts "📚 Seeding genres..."
%w[
  Fantasy Biography History Mystery Non-Fiction
  Science-Fiction Self-Help Thriller Young\ Adult
].each do |name|
  Genre.find_or_create_by!(name: name)
end

# 3️⃣ Task Categories (shared via super-admin)
puts "📋 Seeding task categories..."
%w[
  Borrow Currently\ Reading Finished Must\ Read On\ Deck
].each do |name|
  TaskCategory.find_or_create_by!(name: name, user: admin)
end

# 4️⃣ Seed default books
puts "📖 Seeding default books..."

books = [
  { title: "The Hobbit", author: "J.R.R. Tolkien", genre_name: "Fantasy", published_year: 1937, description: "Bilbo Baggins goes on an unexpected journey to the Lonely Mountain.", cover: nil },
  { title: "The Da Vinci Code", author: "Dan Brown", genre_name: "Mystery", published_year: 2003, description: "Symbologist Robert Langdon uncovers a religious conspiracy.", cover: nil },
  { title: "Pride and Prejudice", author: "Jane Austen", genre_name: "Romance", published_year: 1813, description: "Elizabeth Bennet navigates issues of manners, upbringing, and marriage.", cover: nil },
  { title: "Harry Potter and the Sorcerer’s Stone", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 1997, description: "Harry discovers he's a wizard and attends Hogwarts for the first time.", cover: "HP1.jpg" },
  { title: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 1998, description: "Harry returns to Hogwarts and faces a monster hidden in the Chamber.", cover: "HP2.jpg" },
  { title: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 1999, description: "A fugitive named Sirius Black escapes Azkaban—and he's after Harry.", cover: "HP3.jpg" },
  { title: "Harry Potter and the Goblet of Fire", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 2000, description: "Harry is unexpectedly entered into the dangerous Triwizard Tournament.", cover: "HP4.jpg" },
  { title: "Harry Potter and the Order of the Phoenix", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 2003, description: "Harry builds a secret student group to fight Voldemort’s return.", cover: "HP5.jpg" },
  { title: "Harry Potter and the Half-Blood Prince", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 2005, description: "Dark secrets unfold as Harry uncovers Voldemort’s past.", cover: "HP6.jpg" },
  { title: "Harry Potter and the Deathly Hallows", author: "J.K. Rowling", genre_name: "Fantasy", published_year: 2007, description: "The final battle begins as Harry races to destroy Voldemort’s Horcruxes.", cover: "HP7.jpg" }
]

books.each do |attrs|
  genre = Genre.find_by(name: attrs.delete(:genre_name))
  next unless genre

  book = Book.find_or_initialize_by(title: attrs[:title], author: attrs[:author])
  book.genre ||= genre
  book.user ||= admin
  book.published_year ||= attrs[:published_year]
  book.description ||= attrs[:description]
  book.save!

  if attrs[:cover].present? && !book.cover.attached?
    file_path = Rails.root.join("app/assets/images/#{attrs[:cover]}")
    if File.exist?(file_path)
      book.cover.attach(io: File.open(file_path), filename: attrs[:cover])
      puts "📕 Attached cover for: #{book.title}"
    else
      puts "⚠️ Missing cover file for: #{book.title}"
    end
  end
end

puts "✅ Seed complete!"

