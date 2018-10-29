class User < ApplicationRecord
	before_save { self.email = email.downcase }

	# Email REGEX constant
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	# Validate email field with regex
	validates :email, presence:true , length:{maximum:255} , format:{with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	# Validate name field
	validates :name, presence:true , length:{maximum: 50}

	# Automatically two virtual attributes: password & password_confirmation
	# including presence validations upon object creation and a validation requiring
	# they match. Also comes with an authenticate method.
	has_secure_password
end
