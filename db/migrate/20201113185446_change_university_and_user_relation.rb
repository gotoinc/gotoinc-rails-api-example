class ChangeUniversityAndUserRelation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :universities, :user, index: true
    add_reference :users, :university, index: true
  end
end
