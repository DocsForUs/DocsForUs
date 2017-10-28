class Doctor < ApplicationRecord
  validates :first_name, :last_name, :specialty, :zipcode, presence: true
  validate :email_xor_phone_number

  def self.search_doctor(doctor)
    Doctor.search_api(doctor)
  end

  private
  def email_xor_phone_number
    if email_address.blank? && phone_number.blank?
      errors.add(:base, "Specify either phone number or email address of the Doctor")
    end
  end

  def self.search_api(doctor)
    full_name = doctor[:first_name] +' '+ doctor[:last_name]
    location = doctor[:state] + '-' + doctor[:city]
    p 'this is api call'
    p HTTParty.get("https://api.betterdoctor.com/2016-03-01/doctors?name=#{full_name}&location=#{location}&limit=10&user_key=#{ENV['BETTER_DOCTOR_USER_KEY']}", format: :plain)
  end
end
