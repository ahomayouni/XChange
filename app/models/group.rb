class Group < ApplicationRecord
  has_many :memberships, :dependent => :delete_all 
  has_many :users, through: :memberships, :dependent => :delete_all 
  #belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
