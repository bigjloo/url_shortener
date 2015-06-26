require 'byebug'
# use Rack::Session::Cookie, :key => 'rack.session',
#                            :domain => 'foo.com',
#                            :path => '/',
#                            :expire_after => 2592000, # In seconds
#                            :secret => 'change_me'

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
    # @error = "User did not pass validation MESSAGE"
    redirect to '/urls?error=true'
  end
end

# post '/user_account' do
#   if @authentication_user = User.find_by_email(params[:email])
#     if @authentication_user.password == params[:password]
#       session[:user_id] = @authentication_user.id
#       redirect to "/user/#{@authentication_user.id}"
#     else
#       redirect to "/user/log_in?error_password=true"
#     end
#   else
#     redirect to "/user/log_in?error_email=true"
#   end
# end

get '/user/:id' do
  @user = User.find(params[:id])
  authenticate
  erb :user
end

# get '/user/log_out' do
#   session[:user_id] = nil
#   redirect to '/user/log_in'
# end

def authenticate
  if session[:user_id]
    true
  else
    redirect to "/user/log_in?error_session=true"
  end
end