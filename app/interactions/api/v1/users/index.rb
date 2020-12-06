class Api::V1::Users::Index < AuthenticatedInteraction
  string :group_id, default: nil

  validates :group, presence: true, if: proc { group_id.present? }

  serialize_with UserSerializer

  def execute
    InteractionResult.new(
      users
    )
  end

  private

  def users
    if group.present?
      User.joins(:group_members).where(group_members: {group: group})
    else
      User.preload(:groups, :university).where(university: university)
    end
  end

  def group
    @_group ||= Group.find_by(id: group_id)
  end

  def university
    @_university ||= user.university
  end
end
