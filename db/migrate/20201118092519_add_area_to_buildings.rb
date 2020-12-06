class AddAreaToBuildings < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :area, :float
  end
end
