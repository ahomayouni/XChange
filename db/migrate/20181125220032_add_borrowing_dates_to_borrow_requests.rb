class AddBorrowingDatesToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :start_borrowing, :datetime
    add_column :borrow_requests, :end_borrowing, :datetime
  end
end
