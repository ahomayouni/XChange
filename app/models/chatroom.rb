class Chatroom < ApplicationRecord
    # destroy all messages when chatroom is destroyed
    has_many :messages, dependent: :destroy
    # allows Chatroom to look up each user through which message they send
    has_many :users, through: :messages
    validates :title, presence: true

end
