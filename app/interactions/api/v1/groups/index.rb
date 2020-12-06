class Api::V1::Groups::Index < AuthenticatedInteraction
  integer :university_id, default: nil

  validates :university, presence: true, if: proc { university_id.present? }

  serialize_with GroupSerializer

  def execute
    InteractionResult.new(
      groups
    )
  end

  private

  def groups
    if university.present?
      university.groups
    else
      Group.all
    end
  end

  def university
    @_university ||= University.find_by(id: university_id)
  end
end
