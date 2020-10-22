class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel"
    say_hello
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def say_hello
    ActionCable.server.broadcast( "notification_channel", body: 'notification msg')
  end
end
