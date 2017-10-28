require 'rails_helper'
require 'json'

describe Doctor, type: :model do
  context 'searches the api with first and last name parameters' do
    xit 'returns a single doctor with narrow enough results' do
      doctor = {first_name: "John", last_name: "Anderson", city: "seattle", state: "wa"}
      response = Doctor.search_api(doctor)
      expect(response["meta"]["total"]).to eq 1
    end

    xit 'returns mutliple doctors in a wide result' do
      doctor = {first_name: "John", last_name: "", city: "seattle", state: "wa"}
      response = Doctor.search_api(doctor)

      expect(response["meta"]["total"]).to be > 1
    end

    it 'returns hash with all of the important information of a doctor' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      p 'this is before parse'
      p response.body
      response =  JSON.parse response.body, symbolize_names: true
      p 'this is after parse'
      p response
      expect(response).to eq nil
    end
  end
end
