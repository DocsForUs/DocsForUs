class User < ApplicationRecord
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
  has_secure_password
  has_many :recommendations
  has_many :doctors_users
  has_many :doctors, through: :doctors_users
end
