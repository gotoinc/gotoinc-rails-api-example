require 'rails_helper'

RSpec.describe University, type: :model do
  describe 'realations' do
    it { should have_many(:group).dependent(:destroy) } 
    it { should have_many(:building).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presense_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presense_of(:description) }
    it { should validate_presense_of(:city) }
  end
end
