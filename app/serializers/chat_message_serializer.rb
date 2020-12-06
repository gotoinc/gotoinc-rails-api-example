class ChatMessageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :content, :created_at

  attribute :sender_id do |object|
    object.conversation_participant&.user&.id
  end
end