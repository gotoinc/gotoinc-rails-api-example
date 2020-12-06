class Api::V1::Comments::Destroy < AuthenticatedInteraction
  integer :event_id
  string :id

  validates :event, presence: true, if: proc { event_id.present? }
  validates :comment, presence: true, if: proc { id.present? }

  serialize_with CommentSerializer

  def execute
    comment.destroy
    
    InteractionResult.new(
      comment
    )
  end

  private

  def comment
    @_comment ||= user.comments.find_by(user: user, event: event)
  end

  def event
    @_event ||= Event.find_by(id: event_id)
  end
end