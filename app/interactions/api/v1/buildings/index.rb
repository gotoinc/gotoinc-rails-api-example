class Api::V1::Buildings::Index < AuthenticatedInteraction
  integer :university_id

  validates :university, presence: true, if: proc { university_id.present? }

  serialize_with BuildingSerializer

  def execute
    InteractionResult.new(
      university.buildings
    )
  end

  private

  def university
    @_university ||= University.find_by(id: university_id)
  end
end