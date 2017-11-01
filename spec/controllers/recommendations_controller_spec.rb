require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)}
  describe "initiating a new recommendation" do
    it "returns a status 200" do
      get :add
      expect(response).to have_http_status 200
    end
  end

  describe '#new' do
    context 'when user is logged in' do
      before(:each) do
        create(:doctor)
        get :new, session: {user_id: user.id}, params: { id: 1 }
      end
      it 'assigns a doctor instance variable' do
        expect(assigns[:doctor]).to be_a Doctor
      end
      it 'assigns a recommendation instance variable' do
        expect(assigns[:recommendation]).to be_a Recommendation
      end
      it 'returns OK status' do
        expect(response).to be_ok
      end
      it 'renders the new view' do
        expect(response).to render_template :new
      end
    end
    context 'when user is not logged in' do
      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#create' do
    let!(:doctor) { create(:doctor) }
    context 'when user is logged in' do
      context 'when recommendation is created successfully' do
        before(:each) do
          post :create, params: {"recommendation"=>{"doctor_id"=>doctor.id, "review"=>"fish fish fish", "tags"=>["ham"]}}, session: {user_id: user.id}
        end
        it 'creates a recommendation instance variable' do
          expect(assigns[:recommendation]).to be_a Recommendation
        end
        it 'adds tags to the database if they do not already exist' do
          expect { post :create, params: {"recommendation"=>{"doctor_id"=>doctor.id, "review"=>"fish fish fish", "tags"=>["cats"]}}, session: {user_id: user.id} }.to change{Tag.count}.by(1)
        end
        it 'creates relationship between tags and the recommendation' do
          expect(assigns[:recommendation].tags).to include(Tag.find_by(description: "ham"))
        end
        it 'redirects to dr page' do
          expect(response).to redirect_to doctor_path(doctor)
        end
      end
      context 'when recommendation is not created successfully' do
        before(:each) do
          post :create, params: {"recommendation"=>{"doctor_id"=>doctor.id, "review"=>"fish fish fish", "tags"=>[]}}, session: {user_id: user.id}
        end
        it 'assigns an errors instance variable' do
          expect(assigns[:errors]).to include "You must choose at least one tag."
        end
        it 'renders the new recommendation view' do
          expect(response).to render_template :new
        end
      end
    end
    context 'when user is not logged in' do
      it 'redirects to root path' do
        post :create, params: {"recommendation"=>{"doctor_id"=>doctor.id, "review"=>"fish fish fish", "tags"=>["ham"]}}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#destroy' do
    context 'when an admin is deleting poor content' do
      before(:each) do
        session[:user_id] = admin.id
        doctor = create(:doctor)
        ham = Tag.create(description: 'ham')
        rec = Recommendation.new(user: user, doctor: doctor, review: "fish fish fish")
        rec.tags << ham
        rec.save
        delete :destroy, params: { id: '1' }
        rec2 = Recommendation.new(user: user, doctor: doctor, review: "fishy fishy fishy")
        rec2.tags << ham
        rec2.save
      end
      it 'assigns the recommendation instance variable from params' do
        expect(assigns[:recommendation]).to be_a Recommendation
      end
      it 'deletes the recommendation from the database' do
        expect{ delete :destroy, params: { id: '2' }}.to change{ Recommendation.count }.by -1
      end
      it 'redirects to the homepage' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
