class Group < ApplicationRecord
  belongs_to :university
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members, source: :user

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
