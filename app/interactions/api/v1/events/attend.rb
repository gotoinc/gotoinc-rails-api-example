class Api::V1::Events::Attend < AuthenticatedInteraction
  integer :id

  validate :event, if: proc { id.present? }

  serialize_with EventSerializer

  def execute
    return errors.add(:event, :blank, message: 'Already attended') if already_exist

    event.event_participants.create(user: user)

    InteractionResult.new(
      event
    )
  end

  private

  def already_exist
    event.event_participants.find_by(user: user)
  end

  def event
    @_event ||= Event.find_by(id: id)
  end
end