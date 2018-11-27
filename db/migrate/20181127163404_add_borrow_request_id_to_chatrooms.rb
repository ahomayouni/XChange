class AddBorrowRequestIdToChatrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :borrow_request_id, :integer
  end
end
