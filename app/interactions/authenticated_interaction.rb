class AuthenticatedInteraction < BaseInteraction
  object :jwt, class: Jwt::JsonWebToken, default: nil

  validates :user, presence: {message: 'not found'}

  def execute
    throw 'Override me'
  end

  protected

  def user
    @user ||= User.find_by id: jwt.user_id if jwt.present?
  end

  def is_admin?
    !!user.group_members.first&.admin?
  end

  def token(user)
    Jwt::JsonWebToken.encode({ user_id: user.id }) if user.valid?
  end
end