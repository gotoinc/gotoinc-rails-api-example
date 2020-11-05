require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'relations' do
    it { should belong_to(:university) } 
    it { should have_many(:users).dependent(:destroy) } 
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validates_presence_of(:city) }
  end
end
