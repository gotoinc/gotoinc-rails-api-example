class User < ApplicationRecord
  has_secure_password
  
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :name, :last_name, presence: :true

  belongs_to :group
  has_many :events
  has_many :conversation_participants, dependent: :destroy
  has_many :conversations, through: :conversation_participants, source: :conversation
  has_one :university, through: :group, source: :university

  enum role: {
    student: 0,
    admin: 1
  }
end
