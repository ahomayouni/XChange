class LiveSearch < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :title, presence: true
  validates :from_when, presence: true
  validates :to_when, presence: true
  validates :where, presence: true
  validate :validateTimings

  def validateTimings
    if self.from_when && self.to_when && self.from_when > self.to_when
      errors[:base] << "Start Time must be before End Time"
    end
  end
end
