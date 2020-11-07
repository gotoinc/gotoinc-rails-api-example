class Api::V1::Groups::Create < BaseInteraction
  integer :university_id
  string :name
  string :admin_email

  validate :admin, if: proc { admin_email.present? }
  validate :university, if: proc { university_id.present? }

  serialize_with GroupSerializer

  def execute
    group = Group.new(
      name: name,
      admin_email: admin_email,
      university: university
    )
    errors.merge! group.errors and return unless group.save

    InteractionResult.new(
      group
    )
  end

  private

  def admin
    User.where(email: admin_email).count == 0
  end

  def university
    University.find_by(id: university_id)
  end
end