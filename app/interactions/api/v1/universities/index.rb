class Api::V1::Universities::Index < BaseInteraction
  serialize_with UniversitySerializer

  def execute
    InteractionResult.new(
      universities
    )
  end

  private

  def universities
    University.all
  end
end
