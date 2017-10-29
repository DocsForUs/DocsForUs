class User < ApplicationRecord
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
  has_secure_password
  has_many :recommendations
end
