class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.belongs_to :user, index: true
      t.string :description
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
