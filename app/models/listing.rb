class Listing < ActiveRecord::Base
  attr_accessor
  belongs_to :user
  # TODO: depreciate lsiitng_image controller, move to ActiveStorage
  has_many :listing_images, dependent: :destroy
  has_many :comments, as: :reply
  has_many_attached :images
  has_many :borrow_requests
  validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates :category, presence: true
  validates :price_per_day, presence: true, numericality: {greater_than: 0, only_integer: true}
  validate :validateTimings
  validate :image_type

  #For filtering a listing based on their category
  scope :has_category, -> (category) { where category: category }

  def validateTimings
    if self.start_lending && self.end_lending && self.start_lending > self.end_lending
      errors[:base] << "Start Time must be before End Time"
    end
  end

def thumbnail image_index
  return self.images[image_index].variant(resize: '300x300').processed
end

private
 def image_type
   if images.attached? == false
     errors.add(:images, "are missing!")
   end

   images.each do |image|
     if !image.content_type.in?(%('image/jpeg image/png'))
       errors.add(:images, "needs to be JPEG or PNG")
     end
   end
 end
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
