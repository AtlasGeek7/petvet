class Profile < ApplicationRecord
  belongs_to :user
  validates :full_name, presence: true
  validates :age, presence: true, numericality: { greater_than: 0 }
  validates :gender, presence: true
  validates :address, presence: true
end
