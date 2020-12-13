class Api::V1::Buildings::Create < AuthenticatedInteraction
  integer :university_id
  string :name
  string :description
  string :location
  float :area
  float :lat
  float :lon
  string :available_time

  validates :university, presence: true, if: proc { university_id.present? }
  validates :is_admin?, inclusion: { in: [ true ], message: ' - you are not allowed to do this' }, if: proc { user.present? }

  serialize_with BuildingSerializer

  def execute
    building = university.buildings.create(
      name: name,
      description: description,
      location: location,
      area: area,
      available_time: JSON.parse(available_time),
      lat: lat,
      lat: lon
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