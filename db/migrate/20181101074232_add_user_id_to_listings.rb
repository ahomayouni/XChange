class AddUserIdToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :user_id, :integer
  end
end
