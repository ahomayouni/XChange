class Person < ApplicationRecord
	# a person contains details of each user
	belongs_to :user 

	# create an association for comments so users are able to comment on others
	# a person can have many comment and replies
    has_many :comments, as: :reply
end
