class Api::V1::Events::Update < AuthenticatedInteraction
  integer :id
  with_options default: nil do
    string :name
    string :description
  end
  date :date,
    format: '%d.%m.%Y', default: nil
  integer :building_id, default: nil
  with_options format: '%d.%m.%Y-%H:%M:%S', default: nil do
    date_time :date_from
    date_time :date_to
  end

  validate :is_admin?, if: proc { user.present? }
  validate :event, if: proc { id.present? }
  validate :valid_date?, if: proc { date.present? }
  validate :building, if: proc { building_id.present? }
  validate :booking_building?, if: proc { building.present? }
  validate :possible_booking?, if: proc { booking_building? }

  serialize_with EventSerializer

  def execute
    event.update!(basic_update_params)
    errors.merge! event.errors and return unless event.valid?

    update_booking! if booking_building?
    
    InteractionResult.new(
      event
    )
  end

  private

  def update_booking!
    if event.booking.present?
      event.booking.update(building: building, date_from: date_from, date_to: date_to)
    else
      event.create_booking(building: building, date_from: date_from, date_to: date_to)
    end
  end

  def basic_update_params
    {
      name: name || event.name,
      description: description || event.description,
      date: date || event.date
    }
  end

  def valid_date?
    errors.add :date, 'is invalid' if date < DateTime.now
  end

  def event
    @_event = Event.find_by(id: id)
  end

  def building
    @_building = Building.find_by(id: building_id)
  end

  def booking_building?
    building_id.present? && date_from.present? && date_to.present?
  end

  def day_of_the_week
    @_day_of_the_week ||= date.strftime('%a').downcase.to_sym
  end

  def possible_booking?
    return errors.add :date, 'is invalid' if date_to < date_from

    booking_service = PossibleBookingService.new(building, date, date_from, date_to, event.booking)
    return errors.add :date, 'is taken' unless booking_service.call
  end
end