class User < ApplicationRecord
  has_secure_password
  has_one :profile
  has_many :appointments
  has_many :employees, through: :appointments
  has_many :pets
  has_one :review
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
