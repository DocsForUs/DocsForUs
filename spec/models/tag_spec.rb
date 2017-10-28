require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it { should have_many(:recommendations).through(:recommendations_tags) }
  end
  describe 'validations' do
    let!(:tag) { create(:tag) }
    it 'is valid with a unique description' do
      expect(tag).to be_valid
    end
    it 'is invalid without a description' do
      tag.description = nil
      expect(tag).to_not be_valid
    end
    it 'is invalid without a unique description' do
      tag2 = build(:tag)
      expect(tag2).to_not be_valid
    end
  end

end
