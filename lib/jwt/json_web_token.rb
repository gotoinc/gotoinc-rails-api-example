require 'jwt'

class Jwt::JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      
      JWT.encode(payload, ENV['SECRET'])
    end
 
    def decode(token)
      body = JWT.decode(token, ENV['SECRET'], true)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    def from_token(token)
      payload = decode token
      return if payload.blank?
      new payload.slice(:user_id).symbolize_keys
    end
  end

  attr_reader :user_id

  def initialize(user_id: nil)
    @user_id = user_id
  end

  def valid?
    @user_id.present?
  end

  def to_h
    {
      user_id: @user_id,
      username: @username,
      email: @email
    }
  end

  def encoded
    self.class.encode to_h
  end
 end