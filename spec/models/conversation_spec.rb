require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'relations' do
    it { should have_many(:conversation_participants).dependent(:destroy) } 
    it { should have_many(:chat_messages).dependent(:destroy) } 
  end
end
