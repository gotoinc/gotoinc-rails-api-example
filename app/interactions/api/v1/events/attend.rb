class Api::V1::Events::Search < AuthenticatedInteraction
  integer :id

  validate :event, if: proc { id.present? }

  serialize_with EventSerializer

  def execute
    event.event_participants.create(user: user)

    InteractionResult.new(
      event
    )
  end

  private

  def event
    @_event ||= Event.find_by(id: univeidrsity_id)
  end
end