class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :login!
  
  def login!(user)
    # @current_user = user
    session[:session_token] = user.reset_session_token!
  end
  
  def logout!
    # set session[:token] to nil
    # reset current_user session
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def require_login
    redirect_to new_session_url unless current_user
  end
  
  def require_logoff
    redirect_to cats_url if current_user
  end
  
end
