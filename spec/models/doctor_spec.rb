require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let!(:doctor) { Doctor.create(first_name: 'Elizabeth', last_name: 'Blackwell') }

  describe 'attributes' do
    it 'has a first name' do
      expect(doctor.first_name).to eq 'Elizabeth'
    end

    it 'has a last name' do
      expect(doctor.last_name).to eq 'Blackwell'
    end

    it 'has a full name' do
      expect(doctor.full_name). to eq 'Elizabeth Blackwell'
    end
  end

end
