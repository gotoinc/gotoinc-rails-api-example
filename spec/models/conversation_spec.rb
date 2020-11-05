require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'relations' do
    it { should have_many(:conversation_participant).dependent(:destroy) } 
    it { should have_many(:chat_message).dependent(:destroy) } 
  end
end
