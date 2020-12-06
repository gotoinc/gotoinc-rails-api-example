class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :building, index: true
      t.references :event, index: true
      t.date :date_from
      t.date :date_to
      t.timestamps
    end
  end
end
