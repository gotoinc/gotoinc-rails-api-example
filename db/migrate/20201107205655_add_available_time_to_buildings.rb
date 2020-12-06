class AddAvailableTimeToBuildings < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :available_time, :string
  end
end
