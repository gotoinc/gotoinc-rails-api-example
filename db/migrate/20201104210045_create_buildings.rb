class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :description
      t.string :location
      t.references :university, index: true
      t.timestamps
    end
  end
end
