require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  before(:each) {
    Doctor.create(first_name: 'Rita', last_name: 'Bobita', zipcode: '93023', email_address: 'rita@rita.com')
    session[:employee_id] = 1
  }
  describe "GET #show" do
     it "responds with a status code of 200" do
       get :show, { params: { id: 1 } }
       expect(response).to have_http_status 200
     end

     it "renders the show template" do
       get :show, { params: { id: 1 } }
       expect(response).to render_template(:show)
     end
   end
end
