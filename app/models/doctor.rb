class Doctor < ApplicationRecord
  has_many :recommendations
  validates :first_name, :last_name, :specialty, :zipcode, presence: true
  validate :email_xor_phone_number
  has_many :doctors_insurances
  has_many :insurances, through: :doctors_insurances

  private
  def email_xor_phone_number
    if email_address.blank? && phone_number.blank?
      errors.add(:base, "Specify either phone number or email address of the Doctor")
    end
  end
end
