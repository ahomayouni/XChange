class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token

	before_save { self.email = email.downcase }
	before_create :create_activation_digest

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	# Validate email field with regex
	validates :email, presence:true , length:{maximum:255} , format:{with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	# Validate name field
	validates :name, presence:true , length:{maximum: 50}

	# Automatically two virtual attributes: password & password_confirmation
	# including presence validations upon object creation and a validation requiring
	# they match. Also comes with an authenticate method.
	has_secure_password
	validates :password, presence: true, length: { minimum: 5 }

	# Simply returns a hash of the given string using Bcrypt functions
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string,cost: cost)
	end

	# Will return a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token)) #set the remember_digest in our db column
	end

	# Returns true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest,nil) #set the remember_digest in our db column to nil
	end
	
	def self.search(search)
	  where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%") 
  	end
	private
		def create_activation_digest
			self.activation_token= User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
