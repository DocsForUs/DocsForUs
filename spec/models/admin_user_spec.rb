require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create(:user)}
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1')}

  describe 'admin attribute' do
    it 'does not have admin privilege is attribute is false' do
      expect(user.admin).to be false
    end
  end
end
