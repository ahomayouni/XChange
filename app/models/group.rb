class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  #belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
