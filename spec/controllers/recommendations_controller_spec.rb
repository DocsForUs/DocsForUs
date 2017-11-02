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


  describe "recommendations#edit" do
    let!(:doctor) {create(:doctor)}
    let!(:recommendation) {Recommendation.create!(review: "good job", doctor_id: 1, user_id: user.id)}
    context "when user is not logged in" do
      it "redirects to home page" do
        get :edit, params: {id: 1}
        expect(response).to redirect_to root_path
      end
    end
    context "when user is not the author of the post" do
      it "redirects to home page" do
        get :edit, params: {id: 1}, session: { user_id: 2}
        expect(response).to redirect_to root_path
      end
    end
    context "when user attempts to edit their own post" do
      before(:each) do
        get :edit, params: {id: 1}, session: { user_id: user.id}
      end
      it "returns a status of 200" do
        expect(response).to be_ok
      end
      it "renders the edit page" do
        expect(response).to render_template :edit
      end
      it "assigns the recommendation to edit to an instance variable" do
        expect(assigns[:recommendation]).to eq recommendation
      end
      it "assigns the doctor of the recommendation to edit to an instance variable" do
        expect(assigns[:doctor]).to eq doctor
      end
      it "assigns the default tags to an instance variable" do
        expect(assigns[:tags]).to be_a Hash
      end
    end
  end

  describe "recommendations#update" do
    let!(:doctor) {create(:doctor)}
    let!(:recommendation) {Recommendation.create!(review: "good job", doctor_id: 1, user_id: user.id)}
    context "when user is not logged in" do
      it "redirects to home page" do
        put :update, params: { id: recommendation.id, recommendation: {review: '', doctor_id: doctor.id.to_s, tags: []}}
        expect(response).to redirect_to root_path
      end
    end
    context "successful update" do
      before(:each) do
        put :update, params: { id: recommendation.id, recommendation: {review: "i had a really positive experience", doctor_id: doctor.id.to_s, tags: ['cats']}}, session: { user_id: user.id}
      end
      it "redirects to doctor page" do
        expect(response).to redirect_to doctor_path(doctor)
      end
      it "updates recommendation review" do
        recommendation.reload
        expect(recommendation.review).to eq "i had a really positive experience"
      end
      it "updates recommendation tags to the ones selected on edit page" do
        recommendation.reload
        tags = recommendation.tags.map { |t| t.description}
        expect(tags).to eq ['cats']
      end
    end

  end

  describe '#destroy' do
    context 'when an admin is deleting poor content' do
      before(:each) do
        session[:user_id] = admin.id
        doctor = create(:doctor)
        ham = create(:tag)
        rec = Recommendation.create!(user: user, doctor: doctor, review: "fish fish fish")
        rec.tags << ham
        rec.save
        delete :destroy, params: { id: rec.id }
        rec2 = Recommendation.create!(user: user, doctor: doctor, review: "fishy fishy fishy")
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
