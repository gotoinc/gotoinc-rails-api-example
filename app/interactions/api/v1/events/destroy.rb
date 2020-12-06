class Api::V1::Events::Destroy < AuthenticatedInteraction
  integer :id

  validates :is_admin?, inclusion: { in: [ true ], message: '- you are not allowed to do this' }, if: proc { user.present? }
  validates :event, presence: { message: 'is missing' }, if: proc { id.present? }

  serialize_with EventSerializer

  def execute
    event.destroy

    InteractionResult.new(event)
  end

  private

  def event
    @_event ||= Event.find_by(id: id)
  end
end