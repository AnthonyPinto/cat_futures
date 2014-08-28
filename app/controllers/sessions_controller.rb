class SessionsController < ApplicationController
  before_action :require_logoff, only: [:new, :create]
  before_action :require_login, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:username],
      user_params[:password]
    )
    
    if @user
      # @user.reset_session_token!
      login!(@user)
      # @user.save
      flash[:success] = ["Welcome #{current_user.username}"]
      redirect_to cats_url
    else
      flash[:error] = ["Invalid username and password. Try again."]
      redirect_to new_session_url
    end
  end
  
  
  def user_params
    params.require(:user).permit(
    :username,
    :password
    )
  end
  
  def destroy
    current_user.reset_session_token!
    # current_user.save
    session[:session_token] = nil
    
    redirect_to cats_url
  end
end
