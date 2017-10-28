require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  describe 'associations' do
    it 'belongs to a doctor'
    it 'belongs to a user'
  end
end
