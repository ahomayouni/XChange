class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # add time stamp to actual model ..
  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
