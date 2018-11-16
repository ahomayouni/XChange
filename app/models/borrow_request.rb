class BorrowRequest < ApplicationRecord
  enum status: [:requested, :approved, :declined, :borrowed, :returned]
  belongs_to :listing
  belongs_to :user
end
