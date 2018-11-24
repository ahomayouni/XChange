class User < ApplicationRecord
	# If you are confused about how sometimes we are using self.attribute versus just attribute.
	# This is actually a ruby convention. And also why ruby is disgusting (sometimes)
	# Check this out and hopefully you understand. If not ask me :)
	# https://stackoverflow.com/questions/5183664/why-isnt-self-always-needed-in-ruby-rails-activerecord
	attr_accessor :remember_token, :activation_token, :reset_token

	before_save { self.email = email.downcase }
	before_create :create_activation_digest

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :notifications, foreign_key: :recipient_id, :dependent => :destroy

	has_many :borrow_requests, :dependent => :destroy
  has_many :live_searches, :dependent => :destroy
	# creating an association with groups
	has_many :memberships
	has_many :groups, through: :memberships
	#has_many :owned_groups, class_name: 'Group', foreign_key: 'user_id'

	# creating an association with listings
	has_many :listings , :dependent => :destroy
	has_one :person , :dependent => :destroy

	# creating a one-to-one association with location
 	has_one :location , :dependent => :destroy

	# Create associations to link with private chatroom messages
	has_many :messages
	#this allows each user access to chatroom through their messages
	has_many :chatroom, -> { distinct }, through: :messages

	# Validate email field with regex
	validates :email, presence:true , length:{maximum:255} , format:{with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	# Validate name field
	validates :name, presence:true , length:{maximum: 50}
	has_secure_password
	validates :password, presence: true, length: { minimum: 5 }, :if => :password

	def thumbnail
		if self.person and self.person.image.attachment and self.person.image.content_type.in?(%('image/jpeg image/png'))
			return self.person.image.variant(resize: '300x300').processed
		else
			self.person.image = nil
			return nil
		end
	end
	def password_reset_expired?
		reset_sent_at < 2.hours.ago # Another beauty of rails :)
	end

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

	#Not used anymore, using ransack instead in home_controller.rb
	#def self.search(search)
	#  where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
  #end
	private
		def create_activation_digest
			self.activation_token= User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
