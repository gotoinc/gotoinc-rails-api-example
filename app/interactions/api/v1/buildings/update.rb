class Api::V1::Buildings::Update < AuthenticatedInteraction
  integer :id
  integer :university_id
  string :name
  string :description
  string :location
  string :available_time

  validates :university, presence: true, if: proc { university_id.present? }
  validates :building, presence: true, if: proc { id.present? }

  serialize_with BuildingSerializer

  def execute
    building.update(
      name: name,
      description: description,
      location: location,
      available_time: JSON.parse(available_time)
    )

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