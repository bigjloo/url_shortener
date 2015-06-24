get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/urls' do
  @url = Url.create(url: params[:user_url])
  @new_url = @url.created_at.to_i.to_s + @url.id.to_s
  @updated_url = Url.update(@url.id, :shortened_url => @new_url)

  erb :new_url
end

get '/:short_url' do
  @url = Url.find_by_shortened_url(params[:short_url]).url
  @id = Url.find_by_shortened_url(params[:short_url]).id
  @click_count = Url.find_by_id(@id).click_count+1
  @new_click_count = Url.update(@id, :click_count => @click_count)
  redirect to @url
end

