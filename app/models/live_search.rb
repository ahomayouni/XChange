class LiveSearch < ApplicationRecord
  belongs_to :user
  validates :category, :title, :from_when, :to_when, :where, presence: true
  validate :validateTimings

  def validateTimings
    if self.from_when && self.to_when && self.from_when > self.to_when
      errors[:base] << "Start Time must be before End Time"
    end
  end
end
