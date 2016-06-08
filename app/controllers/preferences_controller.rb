class PreferencesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @preferences = @user.preferences.create(preferences_params)
    redirect_to profile_path
  end

  private
  def preferences_params
    params.require(:preference).permit(:title, :content)
  end
end
