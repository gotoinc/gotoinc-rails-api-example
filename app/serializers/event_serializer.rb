class EventSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :booking, :date

  attribute :total_participants do |object|
    object.event_participants.count
  end

  attribute :comments do |object|
    object.comments.map do |entry|
      entry = CommentSerializer.new(entry)
      entry.as_json
    end
  end

  attribute :building do |object|
    object.booking&.building
  end
end