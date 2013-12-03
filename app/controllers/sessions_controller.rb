class SessionsController < ApplicationController
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> recover1

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# redirect to users page
			sign_in user
			redirect_to user_path(user)
		else
			flash.now[:error] = "Invalid email/password combination"
			render "new"
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
<<<<<<< HEAD
=======
>>>>>>> 3833af5... create sessions controller and start tests
=======
>>>>>>> recover1
end
