class Pet < ApplicationRecord
  belongs_to :user
  has_many :medicines
  has_many :employees, through: :medicines
  validates :name, presence: true, uniqueness: true
  validates :age, presence: true, numericality: { greater_than: 0 }
  validates :gender, presence: true
  validates :breed, presence: true
end
