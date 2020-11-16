class Api::V1::Buildings::Create < AuthenticatedInteraction
  integer :university_id
  string :name
  string :description
  string :location
  string :available_time

  validates :university, presence: true, if: proc { university_id.present? }

  serialize_with BuildingSerializer

  def execute
    building = university.buildings.create(
      name: name,
      description: description,
      location: location,
      available_time: JSON.parse(available_time)
    )
    return errors.merge! building.errors unless building.save

    InteractionResult.new(
      building
    )
  end

  private

  def university
    @_university ||= University.find_by(id: university_id)
  end
end