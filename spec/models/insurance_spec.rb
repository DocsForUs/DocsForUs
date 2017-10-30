require 'rails_helper'

RSpec.describe Insurance, type: :model do
  describe 'associations' do
    it {should have_many(:doctors).through(:doctors_insurances)}
  end
end
