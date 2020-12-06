class AddNoiseLevelToBuilding < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :noise_level, :string
  end
end
