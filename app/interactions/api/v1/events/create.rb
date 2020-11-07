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

  validate :is_admin?, if: proc { user.present? }
  validate :building, if: proc { building_id.present? }
  validate :booking_building?, if: proc { building.present? }
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
    
    available_hours = building.available_time[day_of_the_week]    
    bookings = Booking.joins(:event).where(events: { date: date }, building: building)

    bookings.each do |booking|
      hour_from = booking.date_from.hour
      hour_to = booking.date_to.hour
      if available_hours.include?(hour_from) 
        (hour_from...hour_to).each do |hour|
          available_hours.delete(hour)
        end
      end
    end

    (date_from.hour...date_to.hour).each do |hour|
      return errors.add :date, 'is taken' unless available_hours.include?(hour)
    end
  end
end