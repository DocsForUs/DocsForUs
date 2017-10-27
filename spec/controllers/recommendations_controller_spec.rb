require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do

  describe 'GET #new' do
    it 'visits the new recommendation page' do
      get :new
      expect(response).to have_http_status 200
    end

    it 'creates an instance of a new recommendation' do
      get :new
      expect(assigns(:recommend)).to be_a Recommendation
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
