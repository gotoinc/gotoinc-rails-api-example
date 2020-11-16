class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :users, through: :conversation_participants, source: :user
  has_many :chat_messages, dependent: :destroy
end
