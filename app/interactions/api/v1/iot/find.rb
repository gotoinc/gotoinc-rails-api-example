class Api::V1::Iot::Find < BaseInteraction
  float :lat
  float :lon

  validates :building, presence: { message: 'has invalid coordinates' }, if: proc { lat.present? && lon.present? }

  serialize_with BuildingSerializer

  def execute
    InteractionResult.new(
      building
    )
  end

  private

  # Find building by coordinates
  def building
    @_building ||= Building.where('ROUND(lat::numeric, 4) = ? AND ROUND(lon::numeric, 4) = ?', lat.round(4), lon.round(4)).first
  end
end
