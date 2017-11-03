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
        post :create, params: {user: {username: "Dev", email: "devbootcamp@camp.com", password: '!m0pdxsPd', password_confirmation: '!m0pdxsPd'}}
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
          post :create, params: {user: {username: "llama", email: "devbootcamp@camp.com", password: '!m0pdxsPd', password_confirmation: '!m0pdxsPd'}}
        end
        it "assigns a errors variable with an error about username" do
          expect(assigns[:errors]).to include("Username has already been taken")
        end
      end
      context "email already exists" do
        before(:each) do
          post :create, params: {user: {username: "Dev", email: "llama@llama.com", password: '!m0pdxsPd', password_confirmation: '!m0pdxsPd'}}
        end
        it "assigns a errors variable with an error about email" do
          expect(assigns[:errors]).to include("Email has already been taken")
        end
      end
      context"passwords dont match" do
        before(:each) do
          post :create, params: {user: {username: "Dev", email: "devbootcamp@camp.com", password: '!m0pdxsPd', password_confirmation: '!m0pdxsPd0'}}
        end
        it "assigns a errors variable with an error about password" do
          expect(assigns[:errors]).to include("Password confirmation doesn't match Password")
        end
      end
      context"passwords aren't secure" do
        before(:each) do
          post :create, params: {user: {username: "Dev", email: "devbootcamp@camp.com", password: 'ham', password_confirmation: 'ham'}}
        end
        it "assigns a errors variable with an error of too short" do
          expect(assigns[:errors]).to include("Password is too short (minimum is 8 characters)")
        end
      end
    end
  end

  describe '#show' do
    let!(:user) { create(:user) }
    context 'when user is logged in and going to their own show page' do
      before(:each) do
        get :show, params: {id: user.id}, session: {user_id: user.id}
      end
      it 'renders the user show page' do
        expect(response).to render_template :show
      end
    end
    context "when user is logged in and trying to look at another user's show page" do
      it 'redirects to current users show page' do
        get :show, params: {id: 30}, session: {user_id: user.id}
        expect(response).to redirect_to user_path(user)
      end
    end
    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :show, params: {id: user.id}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#index' do
    let!(:user) { create(:user) }
    let!(:admin) {User.create(username: 'admino', email: 'admino@email.com', password: 'P@ssword1', admin: true)}
    let!(:superadmin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true, superadmin: true)}
    it 'is accessible to superadmins' do
      get :index, session: {user_id: superadmin.id}
      expect(response.status).to eq 200
    end
    it 'is not accessible to non admins' do
      get :index, session: {user_id: user.id}
      expect(response.status).to eq 302
    end
    it 'creates an instance variable collection of user objects based on username search' do
      get :index, params: {usernames: {username: 'llama'}, session: {user_id: superadmin.id}}
      expect(assigns[:users]).to include(user)
    end
    it '@users is nil if passed no params' do
      get :index, session: {user_id: superadmin.id}
      expect(assigns[:users]).to be_nil
    end
    it 'lists all admins when visiting the page' do
      get :index
      expect(assigns[:admins]).to include(admin)
    end
  end

  describe '#update' do
    let!(:user) { create(:user) }
    let!(:admin) {User.create(username: 'admino', email: 'admino@email.com', password: 'P@ssword1', admin: true)}
    let!(:superadmin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true, superadmin: true)}
    it 'can turn a user into an admin' do
      put :update, session: {user_id: superadmin.id}, params: {id: user.id}
      expect(user.reload.admin).to eq true
    end
    it 'can turn an admin back to user' do
      put :update, session: {user_id: superadmin.id}, params: {id: admin.id}
      expect(admin.reload.admin).to eq false
    end
    it 'redirects to admin user management page' do
      put :update, session: {user_id: superadmin.id}, params: {id: admin.id}
      expect(response.status).to eq 302
    end
  end
  describe "#check" do
    it "returns a status 200" do
      get :check
      expect(response.status).to eq 200
    end
    it "renders the check page" do
      get :check
      expect(response).to render_template :check
    end
  end
  describe "users#doc_search" do
    it "should return 200 status" do
      get :doc_search
      expect(response.status).to eq 200
    end
    it "should render the doctor form" do
      get :doc_search
      expect(response).to render_template
    end
  end
  describe "users#find" do
    let!(:doctor) { create(:doctor) }
    before(:each) {get :find, params: {doctor: {first_name:"Georgette", last_name: "Tronkenheim", city: "Seattle", state: "WA"}}}
    it "returns the doctor form page" do
      expect(response).to render_template(:doctor_form)
    end
    it "assigns the variable our_doctors with doctors from database" do
      expect(assigns(:our_doctors).first).to eq(doctor)
    end
  end
  describe "users#doctor_new" do
    let!(:doctor) { create(:doctor) }
    before(:each) { get :doctor_new, params: {id: 1} }
    it "returns a 200 status" do
      expect(response.status).to eq 200
    end
    it "renders the new doctor user page " do
      expect(response).to render_template(:new_doctor_user)
    end
    it "assigns the session[:doctor_id] with the doctor's id" do
      expect(session[:doctor_id]).to eq "1"
    end
  end
  describe "users#doctor_create" do
    context "when valid input are given" do
      let!(:doctor) { create(:doctor) }
      let!(:user) {create(:user)}
      before(:each) { post :doctor_create, params:{user: {username: "ko", email: "ko@ko.com", password: 'Password1!', password_confirmation: 'Password1!'}}}
      it "returns a 302 status" do
        session[:doctor_id] = doctor.id
        expect(response.status).to eq 302
      end
      it "assigns the session user_id with user doctor id" do
        expect(session[:user_id]).to eq 2
      end
    end
    context "when invalid input are given" do
      let!(:doctor) { create(:doctor) }
      let!(:user) {create(:user)}
      before(:each) { post :doctor_create, params:{user: {username: "ko", email: "ko@ko.com", password: 'Password1!', password_confirmation: 'Password1'}}}
      it "returns an error that the passwords dont match" do
        expect(assigns[:errors]).to eq (["Password confirmation doesn't match Password"])
      end
      it "renders the new doctor user" do
        expect(response).to render_template(:new_doctor_user)
      end
    end
  end
  describe "users#doctor_signup" do
    let!(:doctor) { create(:doctor) }
    let!(:user) {create(:user)}
    it "returns a 302 status" do
      session[:doctor_id] = doctor.id
      session[:user_id] = user.id
      get :doctor_signup
      expect(response.status).to eq 302
    end
    it "renders the new doc user form page" do
      get :doctor_signup
      expect(response).to render_template(:new_doc_user_form)
    end
    it "assigns the doctor variable as an instance of Doctor" do
      session[:doctor_id] = doctor.id
      session[:user_id] = user.id
      get :doctor_signup
      expect(assigns[:doctor]).to eq(doctor)
    end
  end
end#end of UsersController
