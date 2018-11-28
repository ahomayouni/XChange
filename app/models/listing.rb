class Listing < ActiveRecord::Base
  attr_accessor
  belongs_to :user
  # TODO: depreciate lsiitng_image controller, move to ActiveStorage
  has_many :listing_images, dependent: :destroy
  has_many :comments, as: :reply
  has_many_attached :images
  has_many :borrow_requests, dependent: :destroy
  validates :title, presence: true, length: {maximum: 50}
  validates :address, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates :category, presence: true
  validate :validateTimings
  validate :image_type
  validate :check_address

  #For filtering a listing based on their category
  scope :has_category, -> (category) { where category: category }

  def validateTimings
    if self.start_lending < Date.today
      errors[:base] << "Start Time cannot be in the past"
    end
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

 def check_address
  results = Geocoder.search(self.address)
  if !results.first  #If location is invalid
    errors.add(:address, "- Meetup Address is invalid. Please try again.")
  end
 end
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
