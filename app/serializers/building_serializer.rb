class BuildingSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :location, :university, :lat, :lon, :area,
             :temperature, :air_quality, :noise_level, :urgent_message, :available_time
end