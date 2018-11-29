class CreateUserReports < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reports do |t|
      t.integer :requester_id
      t.integer :reported_id
      t.string :description

      t.timestamps
    end
  end
end
