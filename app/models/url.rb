class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates :url, format: { with: /https?:\/\/[\S]+/, message: "only valid URL please"}

  end

  def self.update_count(id)
   Url.update(Url.id, :click_count => Url.click_count+1)
  end
end


# def initialize
# end

# def self.before_save()
# end

# url = Url.new
# url.save