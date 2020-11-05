require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relations' do
    it { should belong_to(:creator) }
    it { should have_one(:booking).dependent(:destroy) } 
  end
  
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:date) }
  end
end
