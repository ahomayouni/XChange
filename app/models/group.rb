class Group < ApplicationRecord
  has_many :memberships, :dependent => :delete_all 
  has_many :users, through: :memberships, :dependent => :delete_all 
  #belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  def member_exists(user)
    exists = false
    Membership.all.each do |membership|
      if membership.group_id == self.id and membership.user_id == user.id
        exists = true
      end
    end
    exists
  end
end
