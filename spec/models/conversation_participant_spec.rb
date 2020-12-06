require 'rails_helper'

RSpec.describe ConversationParticipant, type: :model do
  describe 'relations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end
end
