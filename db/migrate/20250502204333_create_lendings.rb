class CreateLendings < ActiveRecord::Migration[7.2]
  def change
    create_table :lendings do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.integer :book_id
      t.datetime :loaned_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
