class ConversationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id

  attribute :users do |object|
    object.users.map do |entry|
      entry = UserSerializer.new(entry)
      entry.as_json
    end
  end

  attribute :chat_messages do |object|
    object.chat_messages.map do |entry|
      entry = ChatMessageSerializer.new(entry)
      entry.as_json
    end
  end
end