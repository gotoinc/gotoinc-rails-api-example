class RemoveGroupAdminAndUserRelationForGroup < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :admin_email
  end
end
