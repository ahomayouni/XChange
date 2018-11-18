class CreateLiveSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :live_searches do |t|
      t.integer :user_id
      t.string :title
      t.text :category
      t.datetime :from_when
      t.datetime :to_when
      t.string :where

      t.timestamps
    end
  end
end
