require 'rails_helper'

RSpec.describe DoctorUsersController, type: :controller do
  let!(:doctor) { create(:doctor) }
  describe 'saved doctors of user profile' do
    before(:each) {post :create, params: {doctor_id: '1'}}
    it 'sends the doctor id and user add in params' do
      expect(assigns[:doctor]).to eq doctor
    end
    it 'creates the association'
    it 'redirects to the users show page'
  end
end
