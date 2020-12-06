class AddAdminEmailToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :admin_email, :string
  end
end
