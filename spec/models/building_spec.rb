require 'rails_helper'

RSpec.describe Building, type: :model do
  describe 'relations' do
    it { should belong_to(:university) }
    it { should have_many(:booking).dependent(:destroy) } 
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
  end

  describe 'serizlizers' do
    it { should serialize(:available_time) }
  end
end
