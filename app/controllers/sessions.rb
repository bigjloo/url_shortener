post '/session/log_in' do
  if @authentication_user = User.find_by_email(params[:email])
    if @authentication_user.password == params[:password]
      session[:user_id] = @authentication_user.id
      redirect to "/user/#{@authentication_user.id}"
    else
      redirect to "/user/log_in?error_password=true"
    end
  else
    redirect to "/user/log_in?error_email=true"
  end
end

get '/session/log_out' do
  session[:user_id] = nil
  redirect to '/user/log_in'
end