require 'rails_helper'

RSpec.describe DoctorUsersController, type: :controller do
  let!(:doctor) { create(:doctor) }
  let!(:user) { create(:user) }
  describe 'saved doctors of user profile' do
    before(:each) { session[:user_id] = user.id }
    before(:each) { post :create, params: { doctor_id: '1' } }
    it 'sends the doctor id in params' do
      expect(assigns[:doctor]).to eq doctor
    end
    it 'creates the association' do
      expect(user.doctors).to include doctor
    end
    it 'redirects to the users show page' do
      expect(response.status).to eq 302
    end
  end

  describe 'deleting doctors from a user profile' do
    before(:each) { session[:user_id] = user.id }
    before(:each) { doctor.users << user }
    before(:each) { delete :destroy, params: { id: '1' } }
    it 'sends the doctor id in params' do
      expect(assigns[:doctor]).to eq doctor
    end
    it 'deletes the association' do
      expect(user.doctors).to_not include doctor
    end
    it 'redirects to the users show page' do
      expect(response.status).to eq 302
    end
  end
end
