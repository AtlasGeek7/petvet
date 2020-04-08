class User < ActiveRecord::Base
  has_many :pets
  has_one :profile
  has_secure_password
end
