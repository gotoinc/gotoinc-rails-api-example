class GroupSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :group_members
end