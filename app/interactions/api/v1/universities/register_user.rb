class Api::V1::Universities::RegisterUser < AuthenticatedInteraction
  string :name
  string :last_name
  integer :group_id, default: nil
  string :email
  string :password

  validate :group, if: proc { group_id.present? }

  serialize_with UserSerializer

  def execute
    @user = User.new(
      name: name,
      last_name: last_name,
      email: email,
      password: password,
      university: university
    )
    errors.merge! @user.errors and return unless @user.valid?

    @user.save

    @user.group_members.create(
      group_id: group_id,
      role: 'student'
    ) if group.present?

    InteractionResult.new(
      @user,
      {
        token: token(@user)
      }
    )
  end

  private

  def university
    user.university
  end

  def group
    Group.find_by(id: group_id)
  end
end
