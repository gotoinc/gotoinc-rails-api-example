class Api::V1::Conversations::Destroy < AuthenticatedInteraction
  integer :id

  validates :conversation, presence: true, if: proc { id.present? }

  serialize_with ConversationSerializer

  def execute
    conversation.destroy
    
    InteractionResult.new(
      conversation
    )
  end

  private

  def conversation
    @_conversation ||= user.conversations.find_by(id: id)
  end
end