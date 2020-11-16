class AddIotEndpoint < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :lat, :float
    add_column :buildings, :lon, :float
  end
end
