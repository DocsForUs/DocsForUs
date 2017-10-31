require 'rails_helper'
require 'json'

describe Doctor, type: :model do
  describe 'associations' do
    it {should have_many(:users).through(:doctors_users) }
  end
  context 'searches the api with first and last name parameters' do

    it 'returns an array of doctors information parsed' do
      doctor = {first_name: "Laura", last_name: "Spring", city: "Seattle", state: "WA"}
      response = Doctor.search_doctor(doctor)
      expect(response[0][:first_name]).to eq "Laura"
    end

    it "it returns an array of the doctor's insurances" do
      doctor = {first_name: "John", last_name: "Anderson", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response).to eq nil
    end
  end
end
