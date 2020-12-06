class CreateConversationParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :conversation_participants do |t|
      t.references :user, index: true 
      t.references :conversation, index: true 
      t.timestamps
    end
  end
end
