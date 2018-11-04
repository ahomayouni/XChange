class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.integer :ref_id
      t.string :location
      t.text :descrip
      t.float :rating

      t.timestamps
    end
  end
end
