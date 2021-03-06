class SessionsController < ApplicationController
  respond_to :html, :json

  def new
    respond_modal_with NIL
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or profile_path
    else
      flash.now[:danger] = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
