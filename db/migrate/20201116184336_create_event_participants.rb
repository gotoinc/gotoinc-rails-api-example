class CreateEventParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :event_participants do |t|
      t.references :user
      t.references :event
      t.timestamps
    end
  end
end
