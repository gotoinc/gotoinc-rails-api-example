class Api::V1::Iot::Update < BaseInteraction
  float :lat
  float :lon
  with_options default: nil do
    string :temperature
    string :noise_level
    string :air_quality
    string :urgent_message
  end

  validates :building, presence: { message: "has invalid coordinates" }, if: proc { lat.present? && lon.present? }

  def execute
    building.update(
      temperature: temperature,
      air_quality: air_quality,
      urgent_message: urgent_message,
      noise_level: noise_level
    )

    send_alert_to_participants! if urgent_message.present?

    InteractionResult.new(
      {
        status: :ok
      }
    )
  end

  private

  # Find building by coordinates
  def building    
    @_building ||= Building.where("ROUND(lat::numeric, 4) = ? AND ROUND(lon::numeric, 4) = ?", lat.round(4), lon.round(4)).first    
  end

  # Find events that are hold at this building
  def event_ids
    today = DateTime.now.strftime("%Y-%m-%d")
    
    Event.where(id: building.bookings.joins(:event).where("date_trunc('day', events.date) = ? ", today).select(:event_id)).pluck(:id)
  end

  # send alert message to each participant
  def send_alert_to_participants!
    message_body = {
      en: "Event you gonna attend is in dangerous - #{error2message(urgent_message)[:en]}",
      uk: "Приміщення заходу який ви плануєте відвідати має термінове повідомлення - #{error2message(urgent_message)[:uk]}"
    }

    message = {
      type: 'alert',
      building_name: building.name,
      message: message_body.to_json
    }

    SendEventAlertJob.perform_later({
      message: message,
      event_ids: event_ids
    })
  end

  def error2message(error)
    case error
    when 'temp_error'
      {
        en: 'temperature is too high, it may be fire on building',
        uk: 'температура дуже висока, можлива пожежа'
      }
    when 'air_error'
      {
        en: 'air conditions are not well',
        uk: 'показники повітря незадовільні'
      }
    when 'noise_error'
      {
        en: 'noise level is too high',
        uk: 'рівень шуму занадто високий'
      }
    end
  end
end