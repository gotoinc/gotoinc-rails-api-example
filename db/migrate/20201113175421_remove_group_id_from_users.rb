class RemoveGroupIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :group, index: true
  end
end
