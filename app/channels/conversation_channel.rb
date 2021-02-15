class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by(id: params[:room])

    stream_from "conversation_channel_#{conversation.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])

    sender = conversation.conversation_participants.find_by(user: current_user)

    chat_message = conversation.chat_messages.create(
      conversation_participant_id: sender.id,
      content: data['content']
    )

    broadcast_message = { chat_message: chat_message, sender_id: current_user.id }

    ActionCable.server.broadcast("conversation_channel_#{data['conversation_id']}", broadcast_message)
  end
end