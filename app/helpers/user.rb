helpers do

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate
    if session[:user_id]
      true
    else
      redirect to "/user/log_in?error_session=true"
    end
  end

end