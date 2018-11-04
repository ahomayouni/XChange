class Subject < ApplicationRecord
    # one subject can have many comment replies
    has_many :comments, as: :reply
end
