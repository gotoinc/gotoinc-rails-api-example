class ConversationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :chat_messages

  attribute :users do |object|
    object.users.map do |entry|
      entry = UserSerializer.new(entry)
      entry.as_json
    end
  end
end