class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.string :name
      t.string :description
      t.date :date
      t.timestamps
    end
  end
end
