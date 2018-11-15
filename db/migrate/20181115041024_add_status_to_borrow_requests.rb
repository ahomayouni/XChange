class AddStatusToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :status, :integer
  end
end
