require 'byebug'

get '/user/log_in' do
  @error= "SESSION ERROR!!!" if !params[:error_session].nil?
  @error= "PASSWORD ERROR!!!" if !params[:error_password].nil?
  @error= "EMAIL ERROR!!!" if !params[:error_email].nil?
  erb :user_log_in
end

get '/user/new' do
  erb :user_new
end

post '/user' do
  @new_user = User.new(params[:user])
  @new_user.save
  unless @new_user.new_record?
    @create_success = "User created success MESSAGE"
    redirect to '/user/log_in'
  else
    redirect to '/urls?error_signup=true'
  end
end

get '/user/:id' do
  @user = User.find(params[:id])
  authenticate
  if session[:user_id] == @user.id
    erb :user
  else
    redirect to '/'
  end
end

