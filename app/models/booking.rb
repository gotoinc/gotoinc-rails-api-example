class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :building

  validates :date_from, :date_to, presence: true
end
