require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:user) { create(:user) }
  let(:doctor) { create(:doctor) }
  let(:doctor2) { Doctor.create(first_name: 'Atul', last_name: 'Gawande', city: 'seattle', state:'wa') }
  describe 'index route for searching' do
    it 'assigns a instance @doctors to doctors that fit the search result' do
      get :find, params: { doctor: {first_name: 'Georgette', last_name: 'Tronkenheim', city: "Seattle", state: "WA"} }
      expect(assigns[:our_doctors]).to include(doctor)
    end
    it "it does not return doctors that do not fit the search request" do
      get :find, params: { doctor: {first_name: 'Georgette', last_name: 'Tronkenheim', city: 'Seattle', state: "WA"} }
      expect(assigns[:our_doctors]).to_not include(doctor2)
    end

  end

  describe "GET #show" do
     it "responds with a status code of 200" do
       get :show, params: {id: doctor.id}
       expect(response).to have_http_status 200
     end

     it "renders the show template" do
       get :show, params: {id: doctor.id}
       expect(response).to render_template(:show)
     end

     it "assigns a tags instance variable" do
       rec = build(:recommendation)
       tag = build(:tag)
       rec.tags << tag
       expect(assigns[:tags]).to include tag
     end
   end

  describe "doctors#new" do
    before(:each) {get :new, session: {user_id: user.id}}
    context "when logged in" do
      it "returns the status of 200 if " do
        expect(response.status).to eq 200
      end
      it "returns the form for creating new doctor" do
        expect(response).to render_template(:new)
      end
    end
  end
  describe "doctors#create" do
    context "when inputs are valid" do
      let!(:doctor) {create(:doctor)}
      before(:each) {post :create, params: {doctor: {first_name: 'Ash', last_name: 'Ram', specialty: 'nuclear-cardiologist',email_address: 'ash@ash.com',zipcode: "98052", street:'150,S jumba', city: 'seattle',state: 'WA'}}}
      it "creates the doctor when all details are provided" do
        expect(Doctor.find_by(email_address: 'ash@ash.com')).to be_a Doctor
      end
      it "redirects to the doctor_path" do
        expect(response.status).to eq 302
      end
      it "checks if the doctor is available in the database first before creating" do
        post :create, params: {doctor: {first_name: 'Georgette', last_name: 'Tronkenheim', specialty: 'Family Practice',email_address: 'georgette@doctor.com',zipcode: "98103", street:'33 Orange St', city: 'Seattle',state: 'WA'}}
        expect(Doctor.where(first_name: 'Georgette').count).to eq 1
      end
    end

    context "when inputs are invalid" do
      before(:each) {post :create, params: {doctor: {first_name: 'Ash', last_name: 'Jay', specialty: 'General',zipcode: 35816,city:'seattle',state:'wa'}}}
      it "assigns the errors variable" do
        expect(assigns[:errors]).to eq (["Specify either phone number or email address of the Doctor"])
      end
      it "does not create the entry on to the database" do
        expect(Doctor.find_by(first_name: 'Ash')).to be nil
      end
    end
  end
  describe "creating insurances for the doctor" do
    before(:each) {post :create, params: {doctor: {first_name: 'John', last_name: 'Anderson', specialty: 'General',zipcode: 35816,city:'seattle',state:'wa',email_address:'ash@ash.com',uid:"c886464a49f370de7f69b20ef7d67585"}}}
    it "creates the insurances if it isnt available in the database" do
      expect(assigns[:doctor].insurances.count).to eq 24
    end
  end

  describe 'doctors#destroy' do
    let!(:user) { create(:user) }
    before(:each) do
      user.doctors << doctor
      delete :destroy, params: {user_id: user.id, id: doctor.id}, session: {user_id: user.id}
    end
    it 'creates a doctor instance variable' do
      expect(assigns[:doctor]).to eq doctor
    end
    it 'redirects to the doctor show page' do
      expect(response).to redirect_to doctor_path(doctor)
    end
    it 'destroys the association between doctor and user' do
      user.reload
      expect(user.doctors).to_not include doctor
    end
  end
end#end of class
