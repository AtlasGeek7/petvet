class Pet < ActiveRecord::Base
  has_one :pet_detail
  belongs_to :user
  belongs_to :employee
  has_many :medicines
end
