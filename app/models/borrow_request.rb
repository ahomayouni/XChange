class BorrowRequest < ApplicationRecord
  enum status: [:requested, :approved, :declined, :borrowed, :returned1]
  belongs_to :listing
  belongs_to :user
end
