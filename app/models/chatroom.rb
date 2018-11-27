class Chatroom < ApplicationRecord
    attr_accessor
    # destroy all messages when chatroom is destroyed
    has_many :messages, dependent: :destroy
    # allows Chatroom to look up each user through which message they send
    has_many :users, -> { distinct }, through: :messages
    #validates :borrow_request_id


end
