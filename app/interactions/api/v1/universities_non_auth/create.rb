class Api::V1::UniversitiesNonAuth::Create < Api::V1::Auth::BaseAuthInteraction
  string :name
  string :last_name
  string :university_name
  string :university_description
  string :university_city
  string :email
  string :password

  serialize_with UserSerializer

  def execute
    @university = University.create(
      name: university_name,
      description: university_description,
      city: university_city
    )

    @user = User.new(
      name: name,
      last_name: last_name,
      email: email,
      password: password,
      university: @university,
      university_admin: true
    )
    errors.merge! @user.errors and return unless @user.save

    InteractionResult.new(
      @user,
      {
        token: token(@user)
      }
    )
  end
end