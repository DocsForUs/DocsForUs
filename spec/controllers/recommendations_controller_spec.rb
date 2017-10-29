require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  let!(:user) { create(:user) }
  describe "initiating a new recommendation" do
    it "returns a status 200" do
      get :add
      expect(response).to have_http_status 200
    end
  end

  describe '#new' do
    context 'when user is logged in' do
      before(:each) do
        get :new, session: {user_id: user.id}
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
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#create' do
    context 'when user is logged in' do
      context 'when recommendation is created successfully' do
        before(:each) do
          post :create, params: {"recommendation"=>{"doctor_id"=>"116", "review"=>"fish fish fish", "tags"=>["ham"]}}, session: {user_id: user.id}
        end
        it 'creates a recommendation instance variable' do
          expect(assigns[:recommendation]).to be_a Recommendation
        end
        it 'adds tags to the database if they do not already exist' do
          expect { post :create, params: {"recommendation"=>{"doctor_id"=>"116", "review"=>"fish fish fish", "tags"=>["cats"]}}, session: {user_id: user.id} }.to change{Tag.count}.by(1)
        end
        it 'creates relationship between tags and the recommendation' do
          expect(assigns[:recommendation].tags).to include(Tag.find_by(description: "ham"))
        end
        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end
      end
      context 'when recommendation is not created successfully' do
        before(:each) do
          post :create, params: {"recommendation"=>{"doctor_id"=>"116", "review"=>"fish fish fish", "tags"=>[]}}, session: {user_id: user.id}
        end
        it 'assigns an errors instance variable' do
          expect(assigns[:errors]).to eq "You must choose at least one tag."
        end
        it 'renders the new recommendation view' do
          expect(response).to render_template :new
        end
      end
    end
    context 'when user is not logged in' do
      it 'redirects to root path' do
        post :create, params: {"recommendation"=>{"doctor_id"=>"116", "review"=>"fish fish fish", "tags"=>["ham"]}}
        expect(response).to redirect_to root_path
      end
    end
  end

end
