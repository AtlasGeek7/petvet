class Employee < ApplicationRecord
  has_secure_password
  has_many :appointments
  has_many :medicines
  has_many :users, through: :appointments
  has_many :pets, through: :medicines
end
