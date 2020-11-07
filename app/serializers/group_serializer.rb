class GroupSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name
end