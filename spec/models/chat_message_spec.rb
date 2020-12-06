require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'relations' do
    it { should belong_to(:conversation) } 
    it { should belong_to(:conversation_participant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end
