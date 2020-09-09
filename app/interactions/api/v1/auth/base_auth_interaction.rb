class Api::V1::Auth::BaseAuthInteraction < BaseInteraction
  protected

  JWT_DATA = %w[username email].freeze

  def token(user)
    data = {}.tap do |obj|
      JWT_DATA.each do |param|
        obj[param.to_sym] = user.public_send(param)
      end
    end
    JsonWebToken.encode(data) if user.valid?
  end
end
