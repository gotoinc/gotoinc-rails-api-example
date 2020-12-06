class Api::V1::Conversations::CreateMessage < AuthenticatedInteraction
  integer :id
  string :content

  validates :conversation, presence: true, if: proc { id.present? }

  serialize_with ConversationSerializer

  def execute
    chat_message = conversation.chat_messages.create(
      conversation_participant_id: sender.id,
      content: content
    )

    send_message!(conversation.id, chat_message)

    InteractionResult.new(
      conversation
    )
  end

  private

  def conversation
    @_conversation ||= user.conversations.find_by(id: id)
  end

  def sender
    conversation.conversation_participants.find_by(user: user)
  end

  def send_message!(conversation_id,chat_message )
    ActionCable.server.broadcast("conversation_channel_#{conversation_id}", chat_message)
  end
end