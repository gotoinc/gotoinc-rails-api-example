class SendEventAlertJob < ApplicationJob
  queue_as :default

  def perform(args)
    options = HashWithIndifferentAccess.new args

    events = Event.preload(:event_participants).where(id: options[:event_ids])

    events.each do |event|
      event.event_participants.pluck(:user_id).uniq.each do |user_id|
        ActionCable.server.broadcast("user_channel_#{user_id}", options[:message])
      end
    end
  end
end
