class Api::V1::Conversations::Show < AuthenticatedInteraction
  integer :id

  validates :conversation, presence: true, if: proc { id.present? }

  serialize_with ConversationSerializer

  def execute
    InteractionResult.new(
      conversation
    )
  end

  private

  def conversation
    @_conversation ||= Conversation.find_by(id: id)
  end
end