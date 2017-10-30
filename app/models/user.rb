class User < ApplicationRecord
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 20 }
  validate :include_special_character
  has_many :recommendations
  has_many :doctors_users
  has_many :doctors, through: :doctors_users

  def include_special_character
    if password.present? && password.include?('!') == false
      errors.add(:special_character_requirement, "Requires one special character")
    end
  end

end
