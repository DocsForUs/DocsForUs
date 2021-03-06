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

  describe '#associate_insurances' do
    it "gets the insurance of the doctor and associates it (when insurance isn't already in the database)" do
      doctor = create(:doctor)
      doctor.associate_insurances("ewrwewrewrew")
      expect(doctor.insurances[0].insurance_name).to eq 'Some insurance'
    end

    it "gets the insurance of the doctor and associates it (when insurance isn't already in the database)" do
      Insurance.create!(insurance_uid: "insurance-insurance", insurance_name: "Some insurance")
      doctor = create(:doctor)
      doctor.associate_insurances("ewrwewrewrew")
      expect(doctor.insurances[0].insurance_name).to eq 'Some insurance'
    end
  end

  describe 'methods' do
    context 'that delete' do
      it 'remove the doctor from the database' do
        doctor = create(:doctor)
        admin = User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)
        expect{ doctor.remove(admin.id) }.to change{ Doctor.count }.by -1
      end
      it 'wont work unless an admin' do
        doctor = create(:doctor)
        user = create(:user)
        expect{ doctor.remove(user.id) }.to change{ Doctor.count }.by 0
      end
    end
  end
end#end of class
