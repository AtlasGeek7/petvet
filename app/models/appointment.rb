class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :employee

  validates :symptoms, presence: true
  validates :full_name, presence: true

  scope :unconfirmed, -> { where(status: "pending") }
  scope :confirmed, -> { where(status: "confirmed") }
  scope :confirmed_and_ordered, -> { confirmed.order('created_at desc') }
end
