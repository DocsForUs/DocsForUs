require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe "initiating a new recommendation" do
    it "returns a status 200" do
      get :add
      expect(response).to have_http_status 200
    end
  end

end
