class PossibleBookingService
  attr_reader :building, :date, :date_from, :date_to, :except_booking

  def initialize(building, date, date_from, date_to, except_booking=nil)
    @building = building
    @date = date
    @date_from = date_from
    @date_to = date_to
    @except_booking = except_booking
  end

  def call
    possible_booking?
  end

  private

  def possible_booking?
    available_hours = building.available_time[day_of_the_week]    
    bookings = Booking.joins(:event).where(events: { date: date }, building: building)
    bookings = bookings.where("bookings.id != ?", except_booking.id) if except_booking.present?
  
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
      return false unless available_hours.include?(hour)
    end
    true
  end

  def day_of_the_week
    @_day_of_the_week ||= date.strftime('%a').downcase.to_sym
  end
end