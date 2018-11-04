class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :rating
      t.integer :listing_id
      t.integer :reply_id
      t.string :reply_type

      t.timestamps
    end
  end
end
