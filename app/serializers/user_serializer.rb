class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :name, :last_name, :group
end
