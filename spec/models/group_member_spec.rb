require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  describe 'relations' do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
  end
end
