class Comment < ApplicationRecord

    belongs_to :reply, polymorphic: true
    has_many :comments, as: :reply
end
