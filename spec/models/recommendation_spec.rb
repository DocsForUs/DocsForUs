require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let!(:rec) { create(:recommendation) }
  # Cant use user factory with same test as recommendation factory - who knew
  let!(:someuser) {User.create(username: 'bob', email: 'bob@email.com', password: 'P@ssword1', admin: false)}
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)}
  describe 'associations' do
    it {should belong_to(:doctor)}
    it {should belong_to(:user)}
    it {should have_many(:tags).through(:recommendations_tags)}
    describe 'validations' do
      it 'is invalid without a doctor' do
        rec.doctor = nil
        expect(rec).to_not be_valid
      end
      it 'is invalid without a user' do
        rec.user = nil
        expect(rec).to_not be_valid
      end
    end

    describe 'methods' do
      it 'can be deleted by admins' do
        expect{ rec.remove(admin.id) }.to change{ Recommendation.count }.by -1
      end
      it 'cant be deleted by regular users' do
        expect{ rec.remove(someuser.id) }.to change{ Recommendation.count }.by 0
      end
    end
  end
end
