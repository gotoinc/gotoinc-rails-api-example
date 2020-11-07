require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relations' do
    it { should belong_to(:group) }
    it { should have_many(:conversation_participants).dependent(:destroy) }
    it { should have_many(:events) }
    it { should have_many(:conversations).through(:conversation_participants) } 
  end

  describe 'validations' do
    it { should validate_presence_of(:name) } 
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should have_secure_password }
  end

  describe 'enums' do
    it 'should have enums of possible roles' do
      should define_enum_for(:role).
        with_values(
          {
            student: 0,
            admin: 1
          }
        )
    end
  end
end
