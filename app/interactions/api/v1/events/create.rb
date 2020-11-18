class Api::V1::Events::Create < AuthenticatedInteraction
  string :name
  string :description
  date :date,
    format: '%d.%m.%Y'
  integer :building_id, default: nil
  with_options format: '%d.%m.%Y-%H:%M:%S', default: nil do
    date_time :date_from
    date_time :date_to
  end

  validates :is_admin?, inclusion: { in: [ true ], message: ' - you are not allowed to do this' }, if: proc { user.present? }
  validates :building, presence: true, if: proc { building_id.present? }
  validates :booking_building?, inclusion: { in: [ true ] }, if: proc { building.present? }
  validate :possible_booking?, if: proc { booking_building? }

  serialize_with EventSerializer

  def execute
    event = Event.new(
      name: name,
      description: description,
      user: user,
      date: date
    )
    errors.merge! event.errors and return unless event.save

    event.create_booking(building: building, date_from: date_from, date_to: date_to) if booking_building?

    InteractionResult.new(
      event
    )
  end

  private

  def building
    @_building ||= Building.find_by(id: building_id)
  end

  def booking_building?
    building_id.present? && date_from.present? && date_to.present?
  end

  def day_of_the_week
    @_day_of_the_week ||= date.strftime('%a').downcase.to_sym
  end

  def possible_booking?
    return errors.add :date, 'is invalid' if date_to < date_from

    booking_service = PossibleBookingService.new(building, date, date_from, date_to)
    return errors.add :date, 'is taken' unless booking_service.call
  end
end