class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :genre, null: false
      t.integer :published_year
      t.text :description

      t.timestamps
    end
  end
end
