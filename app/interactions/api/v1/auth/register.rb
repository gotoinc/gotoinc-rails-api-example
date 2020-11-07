class Api::V1::Auth::Register < Api::V1::Auth::BaseAuthInteraction
  string :name
  string :last_name
  integer :group_id
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
      group: group
    )
    errors.merge! @user.errors and return unless @user.save
    make_admin! if is_admin_of_group?

    InteractionResult.new(
      @user,
      {
        token: token(@user)
      }
    )
  end

  private

  def group
    Group.find_by(id: group_id)
  end

  def is_admin_of_group?
    group_where_user_is_admin.present?
  end

  def group_where_user_is_admin
    @_group_where_user_is_admin ||= Group.where(admin_email: email).first
  end

  def make_admin!
    @user.update(role: 'admin')
  end
end
