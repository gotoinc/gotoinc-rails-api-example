class Building < ApplicationRecord
  belongs_to :university
  has_many :bookings, dependent: :destroy

  validates :name, :location, presence: true

  serialize :available_time, Hash
end
