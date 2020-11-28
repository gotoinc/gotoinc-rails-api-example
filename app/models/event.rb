class Event < ApplicationRecord
  belongs_to :user
  has_one :booking, dependent: :destroy

  validates :name, :description, :date, presence: true

  has_one :university, through: :user, source: :university
  has_many :event_participants, dependent: :destroy
  has_many :users, through: :event_participants, source: :user
  has_many :comments, dependent: :destroy
end
