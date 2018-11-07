class Listing < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 20}
  validates :description, presence: true, length: {minimum: 5, maximum: 50}
  validates :category, presence: true
  validates :price_per_day, presence: true, numericality: {greater_than: 0, only_integer: true}
  validate :validateTimings
  #validates :user_id, presence: true


  def validateTimings
    if self.start_lending && self.end_lending && self.start_lending > self.end_lending
      errors[:base] << "Start Time must be before End Time"
    end
  end

  # creating an association betweeen the user and listings
  belongs_to :user

  # create associations with pictures
  has_many :listing_images, dependent: :destroy
  has_one_attached :image

  #Not used anymore, using ransack instead in home_controller.rb
  #def self.search(search)
  #  where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  #end
end


# == Schema Information
#
# Table name: create_listings
#
# t.string :"title"
# t.text :"description"
# t.text :"category"
# t.integer :"price_per_day"
# t.datetime :"start_lending"
# t.datetime :"end_lending"
#
