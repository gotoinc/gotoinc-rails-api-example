class Group < ApplicationRecord
  belongs_to :university
  has_many :users, dependent: :destroy

  validates :name, :city, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
