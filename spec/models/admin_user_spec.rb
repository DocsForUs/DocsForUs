require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create(:user)}
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)}
  let!(:superadmin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true, superadmin: true)}
  describe 'admin attribute' do
    it 'a normal user created has admin attribute as false' do
      expect(user.admin).to be false
    end
    it 'a user created with admin true will be an admin' do
      expect(admin.admin).to be true
    end
    it 'can be appointed' do
      superadmin.make_admin(user.id)
      expect(user.reload.admin).to be true
    end

    it 'cant appoint admins as a regular admin' do
      admin.make_admin(user.id)
      expect(user.reload.admin).to be false
    end
  end
end
