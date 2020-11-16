class User < ApplicationRecord
  has_secure_password
  
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :name, :last_name, :locale, presence: :true

  has_many :group_members
  has_many :groups, through: :group_members, source: :group
  has_many :events
  has_many :conversation_participants, dependent: :destroy
  has_many :conversations, through: :conversation_participants, source: :conversation
  belongs_to :university
end
