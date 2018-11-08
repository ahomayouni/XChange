class AddOwnedGroupsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :owned_groups, :string
  end
end
