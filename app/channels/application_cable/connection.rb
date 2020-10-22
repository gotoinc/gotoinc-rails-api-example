module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless current_user.present?
    end

    private

    def find_verified_user
      token = request.params["token"]
      decoded_token = Jwt::JsonWebToken.from_token(token) if token.present?
      
      if decoded_token.valid?
        User.find_by(id: decoded_token.user_id)
      else
        nil
      end
    end
  end
end