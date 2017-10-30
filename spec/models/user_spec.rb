require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create(:user)}
  describe 'associations' do
    it { should have_many(:doctors).through(:doctors_users) }
  end
  describe 'validations' do
    context 'it is invalid when' do
      it 'does not have a username' do
        user.username = nil
        expect(user).to_not be_valid
      end
      it 'does not have a password' do
        user.password = nil
        expect(user).to_not be_valid
      end
      it 'does not have an email' do
        user.email = nil
        expect(user).to_not be_valid
      end
      it 'does not have a unique email' do
        user2 = build(:user, username: "cactus")
        expect(user2).to_not be_valid
      end
      it 'does not have a unique username' do
        user2 = build(:user, email: "cactus@cactus.com")
        expect(user2).to_not be_valid
      end
      it 'has a short password' do
        user.password = 'ham'
        expect(user).to_not be_valid
      end
    end
    context 'it is valid when' do
      it 'has all the required fields and email and password are unique' do
        expect(user).to be_valid
      end
    end
  end
  describe 'authentication' do
    it 'returns false if user supplies the wrong password' do
      expect(user.authenticate('cats')).to eq false
    end
    it 'returns the user if they login successfully' do
      expect(user.authenticate('hamnspam7')).to eq user
    end
  end
end
