get '/urls' do
  @urls = Url.all
  @success_message = "Delete successful!" if !params[:success].nil?
  @error = "ERROR!!!" if !params[:error].nil?
  @error = "Email exists in database!" if !params[:error_signup].nil?
  erb :index
end

get '/urls/new' do
  erb :url_form
end

post '/urls' do
  @url = Url.new(params[:url])
  if @url.save
    if logged_in?
      @url.update(user_id: @current_user.id)
      redirect to "/user/#{@current_user.id}"
    end
    redirect to "/urls/#{@url.id}"
  else
    @urls = Url.all
    @error = "Please key in the valid url"
    erb :index
  end
end

get "/urls/:id" do
  @updated_url = Url.find(params[:id])
  erb :new_url
end

get '/:short_url' do
  @url = Url.find_by_shortened_url(params[:short_url])
  @url.update_count
  redirect to @url.url
end

get "/urls/:id/edit" do
  @url = Url.find(params[:id])
  erb :edit_form
end

patch '/urls/:id' do

  @url = Url.find(params[:id])
  @url.update_attributes(params[:url])
  if @url.save
    redirect to "/urls/#{@url.id}"
  else
    @urls = Url.all
    @error = "Please key in the valid url"
    erb :index
  end
end


delete '/urls/:id' do
   @url = Url.find(params[:id])
   @url.destroy
   if logged_in?
     redirect to "/user/#{@current_user.id}"
   else
     redirect to '/urls?success=true'
   end
end