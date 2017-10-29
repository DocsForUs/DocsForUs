require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "new" do
    before(:each) {get :new}
    it "renders new view" do
      expect(response).to render_template(:new)
    end
    it "returns ok status" do
      expect(response).to be_ok
    end
    it "assigns user variable" do
      expect(assigns[:user]).to be_a User
    end
  end
  describe "create" do
    context "when user enters valid input " do
      before(:each) do
        post :create, params: {user: {username: "Dev", email: "devbootcamp@camp.com", password: 'ham', password_confirmation: 'ham'}}
      end
      it "assigns a user variable" do
        expect(assigns[:user]).to be_a User
      end
      it "creates a user in the user table" do
        expect(User.find_by(email: "devbootcamp@camp.com")).to be_a User
      end
      it "sets the current user session" do
        expect(session[:user_id]).to_not be nil
      end
      it "redirects to new user path " do
        expect(response).to redirect_to '/'
      end
    end
    context "when user enters invalid input " do
      let!(:user) {create(:user)}
      context "user name already exists" do
        before(:each) do
          post :create, params: {user: {username: "llama", email: "devbootcamp@camp.com", password: 'ham', password_confirmation: 'ham'}}
        end
        it "assigns a errors variable with an error about username" do
          expect(assigns[:errors]).to include("Username has already been taken")
        end
      end
      context "email already exists" do
        before(:each) do
          post :create, params: {user: {username: "Dev", email: "llama@llama.com", password: 'ham', password_confirmation: 'ham'}}
        end
        it "assigns a errors variable with an error about email" do
          expect(assigns[:errors]).to include("Email has already been taken")
        end
      end
      context"passwords dont match" do
        before(:each) do
          post :create, params: {user: {username: "Dev", email: "devbootcamp@camp.com", password: 'ham', password_confirmation: 'hamnsoap'}}
        end
        it "assigns a errors variable with an error about password" do
          expect(assigns[:errors]).to include("Password confirmation doesn't match Password")
        end
      end
    end
  end
end#end of UsersController
