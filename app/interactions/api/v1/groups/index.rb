class Api::V1::Groups::Index < BaseInteraction
  serialize_with GroupSerializer

  def execute
    InteractionResult.new(
      groups
    )
  end

  private

  def groups
    Group.all
  end
end
