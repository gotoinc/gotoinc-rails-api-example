class SendEventAlertJob < ApplicationJob
  queue_as :default

  def perform(*args)
    options = HashWithIndifferentAccess.new args

    events = Event.preload(:event_participants).where(id: options[:event_ids])

    events.each do |event|
      event.event_participants.each do |participant|
        UserChannel.broadcast_to("user_channel_#{participant.user_id}", options[:message])
      end
    end
  end
end
