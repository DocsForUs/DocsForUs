require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "sessions#new" do
    it "it renders a login page" do
      get :new
      expect(response).to render_template(:new)
    end
    it "redirects to the root page if someone is already logged in" do
      session[:user_id] = "1"
      get :new
      expect(response.status).to eq 302
    end
  end
  describe "session#create" do
    let!(:user) {User.create(email:'ash@ash.com', username:'Ash', password: 'abc')}
    it "creates a new session when input is valid" do
      post :create, params: {user:{email: 'ash@ash.com', password: 'abc'}}
      expect(session[:user_id]).to eq (user.id)
    end
    it "creates a flash notice when input password is invalid" do
      post :create, params: {user:{email: 'ash@ash.com', password: 'abagwg'}}
      expect(flash[:alert]).to eq ("Your email or password is incorrect")
    end
    it "creates a error when input email is invalid" do
      post :create, params: {user:{email: 'ashish@ash.com', password: 'abagwg'}}
      expect(flash[:alert]).to eq ("Your email or password is incorrect")
    end
  end
  describe "session#destroy" do
    let!(:user) {User.create(email:'ash@ash.com', username:'Ash', password: 'abc')}
    before(:each) {post :create, params: {user:{email: 'ash@ash.com', password: 'abagwg'}}}
    it "clears the session" do
      get :destroy
      expect(session[:user_id]).to eq nil
    end
    it "redirects to the root path" do
      get :destroy
      expect(response.status).to eq 302
    end
  end
end
