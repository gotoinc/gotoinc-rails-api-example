class Api::V1::Auth::BaseAuthInteraction < BaseInteraction
  protected

  JWT_DATA = %w[user_id].freeze

  def token(user)
    Jwt::JsonWebToken.encode({ user_id: user.id }) if user.valid?
  end
end
