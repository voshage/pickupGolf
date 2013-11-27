class User < ActiveRecord::Base
	before_save { self.email = email.downcase }

	# reason we dont need attr_accessibles? ---deprectaed_mass_assignment_security
	
	validates :first_name, presence: true 
	validates :last_name, presence: true 

	VALID_PROFILE_NAME_REGEX = /\A[a-zA-Z0-9_-]+\z/
	validates :profile_name, presence: true, uniqueness: true,
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
end
