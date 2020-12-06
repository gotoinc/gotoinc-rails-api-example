require 'rails_helper'

RSpec.describe University, type: :model do
  describe 'realations' do
    it { should have_many(:groups).dependent(:destroy) } 
    it { should have_many(:buildings).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:city) }
  end

  describe "delegations" do
    #it { should delegate_method(:city).to(:groups) }
  end
end
