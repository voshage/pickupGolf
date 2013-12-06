module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		# permanent = { value: remember_token, expires: 20.years.from_now.utc }
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||=  User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end
	
	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		# session is an rails helper
		# acts like a cookie varible that automatically expires upon browser close
		redirect_to(session[:return_to] || default) 
		session.delete(:return_to)
	end

	def store_location
		# save the wanted url if and only if the url request is a get request
		session[:return_to] = request.url if request.get?
	end
end
