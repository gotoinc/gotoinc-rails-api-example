require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'relations' do
    it { should belong_to(:event) }
    it { should belong_to(:building) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date_from) }
    it { should validate_presence_of(:date_to) }
  end
end
