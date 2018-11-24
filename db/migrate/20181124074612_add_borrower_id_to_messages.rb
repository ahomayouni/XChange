class AddBorrowerIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :borrower_id, :integer
  end
end
