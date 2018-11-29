class BorrowRequest < ApplicationRecord
  attr_accessor
  enum status: [:requested, :approved, :declined, :borrowed, :returned, :late]
  belongs_to :listing
  belongs_to :user
  has_many :notifications
end
