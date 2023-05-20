class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :bike

  validates :bike_id, presence: true
  validates :user_id, presence: true
  validates :reservation_date, presence: true
  validates :due_date, presence: true
  validates :city, presence: true
end
