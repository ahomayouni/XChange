class AddSubjectIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :subject_id, :integer
  end
end
