require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let!(:rec) { create(:recommendation) }
  describe 'associations' do
    it {should belong_to(:doctor)}
    it {should belong_to(:user)}
    it 'is invalid without a doctor' do
      rec.doctor = nil
      expect(rec).to_not be_valid
    end
    it 'is invalid without a user' do
      rec.user = nil
      expect(rec).to_not be_valid
    end
  end
end
