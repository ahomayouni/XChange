class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :"title"
      t.text :"description"
      t.text :"category"
      t.integer :"price_per_day"
      t.datetime :"start_lending"
      t.datetime :"end_lending"
    end
  end
end
