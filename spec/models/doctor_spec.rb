require 'rails_helper'
require 'json'

describe Doctor, type: :model do
  describe 'associations' do
    it {should have_many(:users).through(:doctors_users) }
  end

  describe 'validations' do
    it 'is invalid without either a phone number or an email' do
      doctor = build(:doctor, email_address: nil, phone_number: nil)
      expect(doctor).to_not be_valid
    end
  end

  describe '.search_doctor' do
    it 'returns an array of doctors information parsed' do
      doctor = {first_name: "Laura", last_name: "Spring", city: "Seattle", state: "WA"}
      response = Doctor.search_doctor(doctor)
      expect(response[0][:first_name]).to eq "Laura"
    end
  end

  describe '.get_insurances' do
    it "it returns an array of the doctor's insurances" do
      doctor_uid = {uid: "ewrwewrewrew"}
      response = Doctor.get_insurances(doctor_uid)
      expect(response[0][:uid]).to eq "insurance-insurance"
    end
  end
end
