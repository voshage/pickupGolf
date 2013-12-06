class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	
	# reason we dont need attr_accessibles? ---deprectaed_mass_assignment_security

	# https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
	has_secure_password # more info on this method in the link above

	validates :first_name, presence: true 
	validates :last_name, presence: true 

	VALID_PROFILE_NAME_REGEX = /\A[a-zA-Z0-9_-]+\z/
	validates :profile_name, presence: true, uniqueness: true, length: { maximum: 50 },
			                format: {
			                  with: VALID_PROFILE_NAME_REGEX,
			                  message: 'Must be formatted correctly.'
			                }
			                # \A # Beginning of a string (not a line!)
			                # \z # End of a string
			                # [...] # match anything within the brackets
			                # + # match the preceding element one or more times

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, uniqueness: { case_sensitive: false },
  							 format: { 
  								with: VALID_EMAIL_REGEX, 
			                  	message: 'Must be formatted correctly.'
			                   }
	validates :password, length: { minimum: 6 }

	def full_name
		first_name + " " + last_name
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end