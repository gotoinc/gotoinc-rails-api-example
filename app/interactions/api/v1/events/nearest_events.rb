class Api::V1::Events::NearestEvents < AuthenticatedInteraction
  float :lat
  float :lon

  serialize_with EventSerializer

  def execute
    InteractionResult.new(
      events
    )
  end

  private

  # Find building by coordinates
  def building_ids
    @_building_ids ||= Building.where('ROUND(lat::numeric, 2) = ? AND ROUND(lon::numeric, 2) = ?', lat.round(2), lon.round(2)).pluck(:id)
  end

  # Find events that are hold at nearest buildings
  def events
    date = (DateTime.now + 1.week).strftime('%Y-%m-%d')

    Event.where(id: Booking.joins(:event).where("bookings.building_id IN (?) AND date_trunc('day', events.date) < ? ", building_ids, date).select(:event_id))
  end
end
