require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let(:tag) {Tag.create(description: 'lgbt friendly')}
  it 'has a description' do
    expect(tag.description).to eq 'lgbt friendly'
  end
end
