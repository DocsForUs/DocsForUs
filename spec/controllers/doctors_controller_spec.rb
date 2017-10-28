require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:doctor) { Doctor.create(first_name: 'Elizabeth', last_name: 'Blackwell') }
  describe 'index route for searching' do
    it 'assigns a instance @doctors to doctors that fit the search result' do
      get :index, params: { doctor: {first_name: 'Elizabeth', last_name: 'Blackwell'} }
      expect(assigns[:doctors]).to include(doctor)
    end
  end

end
