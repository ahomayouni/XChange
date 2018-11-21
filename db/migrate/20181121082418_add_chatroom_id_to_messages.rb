class AddChatroomIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :chatroom_id, :integer
  end
end
