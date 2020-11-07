class Event < ApplicationRecord
  belongs_to :user
  has_one :booking, dependent: :destroy

  validates :name, :description, :date, presence: true
end
