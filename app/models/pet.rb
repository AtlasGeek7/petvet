class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :medicines
  has_many :employees, through: :medicines
end
