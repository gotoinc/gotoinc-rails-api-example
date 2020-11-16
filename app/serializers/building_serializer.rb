class BuildingSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :location, :available_time, :university
end