class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.references :conversation, index: true
      t.references :conversation_participant, index: true
      t.string :content
      t.timestamps
    end
  end
end
