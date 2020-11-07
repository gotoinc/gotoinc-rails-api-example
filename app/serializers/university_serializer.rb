class UniversitySerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :city
end