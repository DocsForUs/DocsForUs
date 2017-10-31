require 'rails_helper'
require 'json'

describe Doctor, type: :model do
  describe 'associations' do
    it {should have_many(:users).through(:doctors_users) }
  end
  context 'searches the api with first and last name parameters' do
    before(:each) do
      allow(Doctor).to receive(:search_api).and_return(:faked_doctor_search)
    end
    it 'returns an array of a single doctors information parsed' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response).to eq({:location=>[{:city=>"Seattle", :state=>"WA", :street=>"1200 12th Ave S", :zip=>"98144"}, {:city=>"Seattle", :state=>"WA", :street=>"1200 12th Ave S", :zip=>"98144"}], :first=>"Sara", :last=>"Waterman", :gender=>"female"})
    end

    it 'returns an array of doctors information parsed' do
      doctor = {first_name: "John", last_name: "Christopher", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response.count).to eq 3
    end

    it "it returns an array of the doctor's insurances" do
      doctor = {first_name: "John", last_name: "Anderson", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response).to eq nil
    end
  end
end
