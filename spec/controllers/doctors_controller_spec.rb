require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:doctor) { Doctor.create(first_name: 'Elizabeth', last_name: 'Blackwell') }
  let(:doctor2) { Doctor.create(first_name: 'Atul', last_name: 'Gawande') }
  describe 'index route for searching' do
    it 'assigns a instance @doctors to doctors that fit the search result' do
      get :index, params: { doctor: {first_name: 'Elizabeth', last_name: 'Blackwell'} }
      expect(assigns[:doctors]).to include(doctor)
    end
    it "it does not return doctors that do not fit the search request" do
      get :index, params: { doctor: {first_name: 'Elizabeth', last_name: 'Blackwell'} }
      expect(assigns[:doctors]).to_not include(doctor2)
    end

  end

end
