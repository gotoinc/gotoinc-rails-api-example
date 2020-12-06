class ChatMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :conversation_participant

  validates :content, presence: true
end
