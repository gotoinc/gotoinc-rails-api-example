class AddGroupIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :group, index: true
  end
end
