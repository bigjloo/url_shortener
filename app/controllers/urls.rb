get '/urls' do
  @urls = Url.all

  erb :show_all
end

get '/urls/new' do
  @url = Url.new
  erb :url_form
end

post '/urls' do
  @url = Url.new(params[:url])
  if @url.save
    redirect to "/urls/#{@url.id}"
  else
    @urls = Url.all
    @error = "Please key in the valid url"
    # erb :url_form
    erb :show_all
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

#   @url = Url.create(url: params[:user_url])
#   @new_url = @url.created_at.to_i.to_s + @url.id.to_s
#   @updated_url = Url.update(@url.id, :shortened_url => @new_url)
#   p params[:user_url]
#   @updated_url = Url.create_new(params[:user_url])
#   erb :new_url
# end



  # @id = Url.find_by_shortened_url(params[:short_url]).id
  # @click_count = Url.find_by_id(@id).click_count+1
  # @new_click_count = Url.update(@id, :click_count => @click_count)


