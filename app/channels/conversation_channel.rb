class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by(id: params[:conversation_id])

    stream_from "conversation_channel_#{conversation.id}"
    
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data[:conversation_id])

    sender = conversation.conversation_participants.find_by(user: current_user)

    chat_message = conversation.chat_messages.create(
      conversation_participant_id: sender.id,
      content: data[:message]
    )
    ActionCable.server.broadcast("conversation_channel_#{data[:conversation_id]}", chat_message)
  end
end