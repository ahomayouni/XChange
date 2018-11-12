class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.belongs_to :user, index: true
      t.string :address
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
