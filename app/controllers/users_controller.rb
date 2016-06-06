class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user,   only: [:edit, :update]

	respond_to :html, :json

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
		respond_modal_with @user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = 'Welcome to Travel Express!'
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	    @user = User.find(params[:id])
	end

	def update
	    @user = User.find(params[:id])
	    if @user.update_attributes(user_params)
	    	flash[:success] = 'Profile updated'
      		redirect_to @user
	    else
	    	render 'edit'
	    end
	end

	private
		def user_params
			params.require(:user).permit(:login, :first_name, :last_name, :password, :password_confirmation, :email)
	 	end

	 	# Confirms a logged-in user.
	    def logged_in_user
	      unless logged_in?
	      	store_location
	        flash[:danger] = 'Please log in.'
	        redirect_to login_url
	      end
	    end

	    # Confirms the correct user.
		def correct_user
		  @user = User.find(params[:id])
		  redirect_to(root_url) unless current_user?(@user)
		end
end
