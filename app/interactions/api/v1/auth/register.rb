class Api::V1::Auth::Register < Api::V1::Auth::BaseAuthInteraction
  string :username
  string :email
  string :password

  serialize_with UserSerializer

  def execute
    user = User.new(
      username: username,
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
