class AddUniversityIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :university_admin, :boolean, default: false
  end
end
