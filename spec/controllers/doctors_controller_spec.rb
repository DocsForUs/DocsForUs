require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:user) { create(:user) }
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)}
  let(:doctor) { create(:doctor) }
  let(:doctor2) { Doctor.create(first_name: 'Atul', last_name: 'Gawande', city: 'seattle', state:'wa') }
  describe 'doctors#index route for searching' do
    it "assigns tag strings to @tags variable for form dropdown" do
      create(:tag)
      get :index
      expect(assigns[:tags]).to be_an Array
      expect(assigns[:tags]).to include(a_kind_of(String))
    end
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
    let!(:rec) { create(:recommendation, doctor: doctor) }
    let!(:tag) { create(:tag) }
    before(:each) do
      rec.tags << tag
      get :show, params: {id: doctor.id}
    end
     it "responds with a status code of 200" do
       expect(response).to have_http_status 200
     end

     it "renders the show template" do
       expect(response).to render_template(:show)
     end

     it "assigns a tags instance variable" do
       expect(assigns[:tags]).to include tag
     end
     it 'assigns a doctor instance variable' do
       expect(assigns[:doctor]).to eq doctor
     end
   end

  describe "doctors#new" do
    context "when logged in" do
      before(:each) {get :new, session: {user_id: user.id}}
      it "returns the status of 200 if " do
        expect(response.status).to eq 200
      end
      it "returns the form for creating new doctor" do
        expect(response).to render_template(:new)
      end
    end
    context "when not logged in" do
      before(:each) { get :new }
      it "sets a flash alert message" do
        expect(flash[:alert]).to eq "You must be logged in to add a doctor"
      end
      it "redirects to login page" do
        expect(response.status).to be 302
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

    context "when user is a doctor" do
      before(:each) do
        session[:doctor] = true
        session[:user_id] = user.id
        post :create, params: {doctor: {first_name: 'Ash', last_name: 'Ram', specialty: 'nuclear-cardiologist',email_address: 'ash@ash.com',zipcode: "98052", street:'150,S jumba', city: 'seattle',state: 'WA'}}
      end
      it 'sets the current users doctor id to the created doctors id' do
        expect(user.doctor).to eq Doctor.last
      end
      it 'redirects to doctor path' do
        expect(response).to redirect_to doctor_path(Doctor.last)
      end
    end
  end

  describe "creating insurances for the doctor" do
    before(:each) {post :create, params: {doctor: {first_name: 'Laura', last_name: 'Spring', specialty: 'Family Medicine',zipcode: '98103',city:'Seattle',state:'WA',uid:"ewrwewrewrew"}}}
    xit "creates the insurances if it isnt available in the database" do
      expect(assigns[:doctor].insurances.count).to eq 2
    end
  end

  describe "deleting a doctor as an admin" do
    context 'when an admin is deleting a doctor' do
      before(:each) do

        session[:user_id] = admin.id
        doctor = create(:doctor)
        doctor2 = build(:doctor)
        doctor2.first_name = "Mary"
        doctor2.save
        delete :destroy, params: { id: '1' }
      end
      it 'assigns the doctor instance variable from params' do
        expect(assigns[:doctor]).to be_a Doctor
      end
      it 'deletes the doctor from the database' do
        expect{ delete :destroy, params: { id: '2' }}.to change{ Doctor.count }.by -1
      end
      it 'redirects to the homepage' do
        expect(response).to redirect_to root_path
      end
    end
  end

end#end of class
