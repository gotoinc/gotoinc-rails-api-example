class Api::V1::Auth::Register < Api::V1::Auth::BaseAuthInteraction
  string :name
  string :last_name
  string :group_id
  string :email
  string :password

  serialize_with UserSerializer

  def execute
    user = User.new(
      name: name,
      email: email,
      password: password
    )
    errors.merge! user.errors and return unless user.save

    InteractionResult.new(
      user,
      {
        token: token(user)
      }
    )
  end
end
