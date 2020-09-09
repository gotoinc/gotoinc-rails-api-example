class Api::V1::Users::Me < AuthenticatedInteraction
  serialize_with UserSerializer

  def execute
    InteractionResult.new(
      user
    )
  end
end
