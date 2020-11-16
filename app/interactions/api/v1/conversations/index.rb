class Api::V1::Conversations::Index < AuthenticatedInteraction
  serialize_with ConversationSerializer

  def execute
    InteractionResult.new(
      conversations
    )
  end

  private

  def conversations
    @_conversations ||= user.conversations
  end
end