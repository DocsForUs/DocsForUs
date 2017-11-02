class User < ApplicationRecord
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
  has_secure_password
  validates :password, {confirmation: true, presence: true, length: { minimum: 8, maximum: 20  }, format: { with: /((?:(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.*\d).*))/x, message: "must contain the following: a lowercase letter, an uppercase letter, a digit, a non-word character or symbol" } }
  has_many :recommendations
  has_many :doctors_users
  has_many :doctors, through: :doctors_users

  def make_admin(admin)
    if admin.superadmin == true
      self.update_attribute(:admin, true)
    end
  end

  def remove_admin(admin)
    if admin.superadmin == true
      self.update_attribute(:admin, false)
    end
  end

end
