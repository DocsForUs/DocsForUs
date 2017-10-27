require 'rails_helper'

describe IndexController, type: :controller do
  describe "/home" do
    it "returns a 200 status code" do
      get :home
      expect(response.status).to eq 200
    end
    it "renders the home page" do
      expect(get :home).to render_template(:index)
    end
  end
end
