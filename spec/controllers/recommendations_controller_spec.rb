require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe "initiating a new recommendation" do
    it "returns a status 200" do
      get :add
      expect(response).to have_http_status 200
    end
  end

  describe '#new' do
    let!(:user) { create(:user) }
    before(:each) do
      get :new, session: {user_id: user.id}
    end
    it 'assigns a doctor instance variable' do
      expect(assigns[:doctor]).to be_a Doctor
    end
    it 'assigns a recommendation instance variable' do
      expect(assigns[:recommendation]).to be_a Recommendation
    end
    it 'returns OK status' do
      expect(response).to be_ok
    end
    it 'renders the new view' do
      expect(response).to render_template :new
    end
  end

end
