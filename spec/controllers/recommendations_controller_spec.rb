require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do

  describe 'GET #new' do
    it 'visits the new recommendation page' do
      get :new
      expect(response).to have_http_status 200
    end
  end

end
