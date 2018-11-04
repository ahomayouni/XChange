class Comment < ApplicationRecord
    # one comment can have many comments reply to it
    belongs_to :reply, polymorphic: true
    has_many :comments, as: :reply
end
