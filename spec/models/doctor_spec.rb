require 'rails_helper'

describe Doctor, type: :model do
  context 'searches the api with first and last name parameters' do
    it 'makes a reponse body that is not nil' do
      doctor = {first_name: "John", last_name: "Anderson", city: "seattle", state: "wa"}
      response = Doctor.search_api(doctor)
      p response.body
      expect(response["meta"]["total"]).to eq 1
    end
  end
end
