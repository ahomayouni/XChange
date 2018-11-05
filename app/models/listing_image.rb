class ListingImage < ApplicationRecord
  belongs_to :listing
  validate :no_more_than_5_images

  def no_more_than_5_images
  	img_count = ListingImage.where(listing_id: listing_id).count
  	if img_count > 4
  		errors.add(:image, "Sorry, Can't have more than 5 profile pictures")
  	end
  end
end
