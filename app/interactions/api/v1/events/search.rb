class Api::V1::Events::Search < AuthenticatedInteraction
  with_options default: nil do
    string :s
    string :university_id
  end

  validate :university, if: proc { university_id.present? }

  serialize_with EventSerializer

  def execute
    InteractionResult.new(
      events
    )
  end

  private

  def events    
    @_events ||= begin
      e = Event.joins(user: :groups).where("events.name LIKE ?", "%#{s}%")      
      e = e.where("groups.university_id = ?", university_id) if university.present?
      e
    end
  end

  def university
    @_university ||= University.find_by(id: university_id)
  end
end