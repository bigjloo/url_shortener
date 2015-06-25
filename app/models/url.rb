class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates :url, format: { with: /https?:\/\/[\S]+/}
  before_create :generate_shortened_url

  def update_count

    self.click_count += 1
    save
  end



  private

  def generate_shortened_url
    self.shortened_url = SecureRandom.hex(5)
  end


end


  # def self.create_new(user_url)
  #   @url = Url.create(url: user_url)
  #   # if @url.new_record?
  #     # redirect to error page
  #   @new_url = @url.created_at.to_i.to_s + @url.id.to_s
  #   @updated_url = Url.update(@url.id, :shortened_url => @new_url)
  # end

