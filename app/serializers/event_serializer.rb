class EventSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :booking, :date

  attribute :building do |object|
    object.booking&.building
  end
end