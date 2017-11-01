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
    it 'is invalid without a default boolean' do
      tag.default = nil
      expect(tag).to_not be_valid
    end
    it 'is invalid without a category' do
      tag.category = nil
      expect(tag).to_not be_valid
    end
  end

  describe '.default_tags' do
    it 'returns a hash of tags by default categories' do
      expect(Tag.default_tags[:safe]).to all have_attributes(default: true, category: "safe")
    end
  end

  describe '.tag_sort' do
    before(:each) do
      tag = create(:tag)
    end
    it 'returns an array of tags with new custom tags' do
      expect(Tag.tag_sort(["likes cats", "sandwiches"])).to include Tag.find_by(description: "sandwiches")
    end
    it 'return an array of tags with existing tags' do
      expect(Tag.tag_sort(["likes cats", "sandwiches"])).to include Tag.find_by(description: "likes cats")
    end
    it 'creates any new tags in the database' do
      expect { Tag.tag_sort(["likes cats", "sandwiches"]) }.to change{ Tag.count }.by(1)
    end
  end

end
