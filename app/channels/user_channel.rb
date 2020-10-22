class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{current_user.id}"
    say_hello
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def say_hello(data)    
    ActionCable.server.broadcast( "user_channel_#{current_user.id}", body: data || 'default')
  end
end