require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  describe 'associations' do

    it 'belongs to a doctor' do
      expect(rec.doctor).to eq doctor
    end
    it 'belongs to a user' do
      expect(rec.user).to eq user
    end
  end
end
