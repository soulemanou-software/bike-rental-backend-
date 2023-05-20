class Bike < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :brand, presence: true
  validates :daily_rate, presence: true, numericality: { greater_than: 0 }
  validates :images, presence: true
  validates :color, presence: true
end
