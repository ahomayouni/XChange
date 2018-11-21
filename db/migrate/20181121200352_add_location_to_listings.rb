class AddLocationToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :address, :string
    add_column :listings, :latitude, :string
    add_column :listings, :longitude, :string
  end
end
