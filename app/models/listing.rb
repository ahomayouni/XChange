class Listing < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 20}
  validates :description, presence: true, length: {minimum: 5, maximum: 50}
  validates :category, presence: true
  validates :price_per_day, presence: true
  validate :validateTimings

  def validateTimings
    if self.start_lending && self.end_lending && self.start_lending > self.end_lending
      errors[:base] << "Start Time must be before End Time"
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
#