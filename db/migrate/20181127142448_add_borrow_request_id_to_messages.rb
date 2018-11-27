class AddBorrowRequestIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :borrow_request_id, :integer
  end
end
