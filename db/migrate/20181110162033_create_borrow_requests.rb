class CreateBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :borrow_requests do |t|
      t.integer :listing_id
      # borrower id
      t.integer :user_id
      t.timestamps
    end
  end
end
