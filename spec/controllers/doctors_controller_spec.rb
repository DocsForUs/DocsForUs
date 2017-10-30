require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
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

     xit "assigns a tags instance variable" do
       rec = build(:recommendation)
       tag = build(:tag)
       rec.tags << tag
       expect(assigns[:tags]).to include tag
     end
   end

  describe "doctors#new" do
    before(:each) {get :new}
    it "returns the status of 200" do
      expect(response.status).to eq 200
    end
    it "returns the form for creating new doctor" do
      expect(response).to render_template(:new)
    end
  end
  xdescribe "doctors#create" do
    context "when inputs are valid" do
      before(:each) {post :create, params: {doctor: {first_name: 'Ash', last_name: 'Jay', specialty: 'General',email_address: 'ash@ash.com',zipcode: 35816, city: 'seattle',state: 'wa'}}}
      it "creates the doctor when all details are provided" do
        expect(Doctor.find_by(email_address: 'ash@ash.com')).to be_a Doctor
      end
      it "redirects to the doctor_path" do
        expect(response.status).to eq 302
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
    xit "creates the insurances if it isnt available in the database" do
      expect(assigns[:doctor].insurances.count).to eq 24
    end
  end
end#end of class
