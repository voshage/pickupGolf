class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def create
		@user = User.new(user_params)

   		respond_to do |format|
			if @user.save
				format.html do
					flash[:notice] = "Welcome to the Sample App!"
		        	redirect_to users_path(@user)
		        end
			else
				format.html { render action: "new" }
			end
		end
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :profile_name,
										 :email, :password, :password_confirmation)
	end
end
