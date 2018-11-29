class Group < ApplicationRecord
  has_many :memberships, :dependent => :delete_all 
  has_many :users, through: :memberships, :dependent => :delete_all 
  
  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 5, maximum: 1000}
  validates :isPublic, presence: true
    
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
