class Api::V1::Groups::Create < AuthenticatedInteraction
  integer :university_id
  string :name
  integer :admin_id

  validate :is_admin?, if: proc { user.present? }
  validates :university, presence: true, if: proc { university_id.present? }
  validates :admin, presence: true, if: proc { admin_id.present? }

  serialize_with GroupSerializer

  def execute
    group = Group.new(
      name: name,
      university: university
    )
    errors.merge! group.errors and return unless group.save

    group.group_members.create(
      role: 'admin',
      user: admin
    )

    InteractionResult.new(
      group
    )
  end

  private

  def admin
    @_admin ||= User.find_by(id: admin_id)
  end

  def university
    @_university ||= University.find_by(id: university_id)
  end
end