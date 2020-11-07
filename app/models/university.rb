class University < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :buildings, dependent: :destroy

  validates :name, :city, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
