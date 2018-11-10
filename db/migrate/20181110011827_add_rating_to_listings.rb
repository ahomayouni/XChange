class AddRatingToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :rating, :float
  end
end
