require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relations' do
    it { should belong_to(:group) }
    it { should have_many(:conversation_participant).dependent(:destroy) }
    it { should have_many(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) } 
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    context 'should have secure password' do
      it { should respond_to(:password) }
      it { should respond_to(:password_confirmation) }
      it { should respond_to(:authenticate) }
    end
  end

  describe 'enums' do
    it 'should have enums of possible roles' do
      should define_enum_for(:roles).
        with_values(
          {
            student: 0,
            admin: 1
          }
        )
    end
  end
end
