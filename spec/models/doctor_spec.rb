require 'rails_helper'
require 'json'

describe Doctor, type: :model do
  context 'searches the api with first and last name parameters' do
    
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
