class AddOwnerToUniversity < ActiveRecord::Migration[6.0]
  def change
    add_reference :universities, :user, index: true
  end
end
