require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'it is invalid when' do
      it 'does not have a username'
      it 'does not have a password'
      it 'does not have a password'
      it 'does not have a unique email'
      it 'does not have a unique username'
    end
    context 'it is valid when' do
      it 'has all the required fields and email and password are unique'
    end
  end
  describe 'authentication' do
    it 'returns false if user supplies an email which does not match an account'
    it 'returns false if user supplies the wrong password'
    it 'returns the user if they login successfully'
  end
end
