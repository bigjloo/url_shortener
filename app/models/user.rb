class User < ActiveRecord::Base
  # Remember to create a migration!
  validates_uniqueness_of :email

  has_many :urls

end
