class User < ActiveRecord::Base
    has_secure_password
    has_one :user_details
    has_many :appointments
    has_many :employees, through: :appointments
    has_many :pets
    has_many :reviews
end
