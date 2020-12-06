class CreateGroupMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_members do |t|
      t.references :user, index: true 
      t.references :group, index: true 
      t.timestamps
    end
  end
end
