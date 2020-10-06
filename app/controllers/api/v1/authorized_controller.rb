class Api::V1::AuthorizedController < Api::V1::BaseController
  before_action :validate_jwt!

  protected

  def params
    super.merge jwt: jwt
  end

  def jwt
    @_jwt ||= Jwt::JsonWebToken.from_token(token) if token
  end

  def token
    @_token ||= request.headers['AUTHORIZATION'].to_s.split(' ').last
  end

  def validate_jwt!
    render json: { error: 'Invalid token' }, status: :unauthorized unless jwt.present? && jwt.valid?
  end
end
