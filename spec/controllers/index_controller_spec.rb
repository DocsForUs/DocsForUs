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

  describe "index#about" do
    it "returns a 200 status code" do
      get :about
      expect(response.status).to eq 200
    end
    it "renders the about page" do
      expect(get :about).to render_template(:about)
    end
  end

  describe "index#resources" do
    it "returns a 200 status code" do
      get :resources
      expect(response.status).to eq 200
    end
    it "renders the resources page" do
      expect(get :resources).to render_template(:resources)
    end
  end
end
