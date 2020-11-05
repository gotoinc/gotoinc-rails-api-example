class Api::V1::Auth::Login < Api::V1::Auth::BaseAuthInteraction
  string :identifier
  string :password

  validates :user, presence: { message: 'not found' }
  validate :password_correct?, if: proc { user.present? && password.present? }

  serialize_with UserSerializer

  def execute
    InteractionResult.new(
      user,
      {
        token: token(user)
      }
    )
  end

  private

  def password_correct?
    errors.add :credentials, 'invalid' unless user.authenticate(password)
  end

  def user
    @_user ||= User.find_by(email: identifier)
  end
end
