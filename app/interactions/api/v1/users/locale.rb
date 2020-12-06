class Api::V1::Users::Locale < AuthenticatedInteraction
  string :locale

  validates :locale, acceptance: { accept: ['en', 'uk'] }

  serialize_with UserSerializer

  def execute
    user.update(locale: locale)

    InteractionResult.new(
      user
    )
  end
end
