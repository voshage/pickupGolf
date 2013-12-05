class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]

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
					sign_in @user
		        	redirect_to users_path(@user)
		        end
			else
				format.html { render action: "new" }
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
			redirect_to user_path(@user)
		else 
			flash.now[:error] = "Invalid Entry"
			render action: "edit"
		end
	end

		def user_params
			params.require(:user).permit(:first_name, :last_name, :profile_name,
											 :email, :password, :password_confirmation)
		end

		def signed_in_user
			redirect_to signin_path, notice: "Please sign in." unless signed_in?
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_url unless current_user?(@user)
		end
end
