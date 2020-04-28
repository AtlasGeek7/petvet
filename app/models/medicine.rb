class Medicine < ApplicationRecord
  belongs_to :pet
  belongs_to :employee
  validates :rx_name, presence: true
  validates :pill_count, presence: true, numericality: { greater_than: 0 }
  validates :pill_size, presence: true, numericality: { greater_than: 0 }
end
