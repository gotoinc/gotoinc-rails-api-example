class Api::V1::Conversations::Create < AuthenticatedInteraction
  integer :user_id

  serialize_with ConversationSerializer

  def execute
    conversation = Conversation.create

    conversation.conversation_participants.create(user: user)
    conversation.conversation_participants.create(user_id: user_id)

    InteractionResult.new(
      conversation
    )
  end
end