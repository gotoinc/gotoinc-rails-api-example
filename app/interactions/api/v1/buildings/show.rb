class Api::V1::Buildings::Show < AuthenticatedInteraction
  integer :university_id
  integer :id

  validates :university, presence: true, if: proc { university_id.present? }
  validates :building, presence: true, if: proc { id.present? }

  serialize_with BuildingSerializer

  def execute
    InteractionResult.new(
      building
    )
  end

  private

  def university
    @_university ||= University.find_by(id: university_id)
  end

  def building
    @_building ||= university.buildings.find_by(id: id)
  end
end