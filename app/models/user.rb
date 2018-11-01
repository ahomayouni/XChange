class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token

	before_save { self.email = email.downcase }
	before_create :create_activation_digest

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# creating an association with users
	has_many :listings

	# Validate email field with regex
	validates :email, presence:true , length:{maximum:255} , format:{with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	# Validate name field
	validates :name, presence:true , length:{maximum: 50}
	has_secure_password
	validates :password, presence: true, length: { minimum: 5 }


	def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
  	end

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

	def forget
		update_attribute(:remember_digest,nil) #set the remember_digest in our db column to nil
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest , User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now # Amazing gem that has everything
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
