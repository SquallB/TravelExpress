class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
 
  		if @user.save
  			flash[:success] = "Welcome to Travel Express!"
    		redirect_to root_path
  		else
    		render 'new'
  		end
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
	 	end
end
