class AddRatingToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :rating, :float
  end
end
