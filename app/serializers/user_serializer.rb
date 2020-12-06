class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :name, :last_name, :groups, :locale, :university, :university_admin,
    :group_members

  attribute :main_group_name do |object|
    object.groups.first&.name
  end

  attribute :full_name do |object|
    "#{object.name} #{object.last_name}"
  end
end
