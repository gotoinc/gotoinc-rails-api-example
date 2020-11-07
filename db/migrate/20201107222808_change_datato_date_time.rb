class ChangeDatatoDateTime < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :date_from, :datetime
    change_column :bookings, :date_to, :datetime
  end
end
