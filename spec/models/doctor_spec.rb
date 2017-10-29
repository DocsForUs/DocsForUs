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

    xit 'returns hash with all information of a single doctor' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_api(doctor)
      response =  JSON.parse response.body, symbolize_names: true
      expect(response[:meta][:total]).to eq 1
    end

    xit 'returns the first name of a doctor from an api call' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response).to eq 'Sara'
    end

    xit 'returns the city a doctor from an api call' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      expect(response).to eq 'Seattle'
    end

    xit 'returns an array of a single doctors information parsed' do
      doctor = {first_name: "Sara", last_name: "Waterman", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      p response
      expect(response).to eq({:location=>[{:city=>"Seattle", :state=>"WA", :street=>"1200 12th Ave S", :zip=>"98144"}, {:city=>"Seattle", :state=>"WA", :street=>"1200 12th Ave S", :zip=>"98144"}], :first=>"Sara", :last=>"Waterman", :gender=>"female"})
    end

    it 'returns an array of doctors information parsed' do
      doctor = {first_name: "John", last_name: "Christopher", city: "seattle", state: "wa"}
      response = Doctor.search_doctor(doctor)
      p response[0][:first_name]
      expect(response.count).to eq 3
    end

  end
end
