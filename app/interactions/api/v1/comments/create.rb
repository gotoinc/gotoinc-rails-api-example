class Api::V1::Comments::Create < AuthenticatedInteraction
  integer :event_id
  string :title
  string :content, default: nil

  validates :event, presence: true, if: proc { event_id.present? }
  validates :participant?, presence: true, if: proc { event.present? }

  serialize_with CommentSerializer

  def execute
    comment = event.comments.create(user: user, title: title, content: content)

    InteractionResult.new(
      comment
    )
  end

  private

  def participant?
    event.event_participants.find_by(user: user)
  end

  def event
    @_event ||= Event.find_by(id: event_id)
  end
end