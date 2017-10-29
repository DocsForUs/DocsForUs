class Doctor < ApplicationRecord
  has_many :recommendations
  validates :first_name, :last_name, :specialty, :zipcode, presence: true
  validate :email_xor_phone_number

  def self.search_doctor(doctor)
    response = Doctor.search_api(doctor)
    response =  JSON.parse response.body, symbolize_names: true
    doctors_array = []
    if response[:data]
      response[:data].each do |doc|
        doctors_array << Doctor.doctor_data(doc)
      end
    end
    doctors_array
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
    HTTParty.get("https://api.betterdoctor.com/2016-03-01/doctors?name=#{full_name}&location=#{location}&limit=10&user_key=#{ENV['BETTER_DOCTOR_USER_KEY']}", format: :plain)
  end

  def self.doctor_data(doctor)
    doctor_hash = {
      first_name: doctor[:profile][:first_name],
      last_name: doctor[:profile][:last_name],
      gender: doctor[:profile][:gender],
      specialty: doctor[:specialties][0][:name],
      phone: doctor[:practices].last[:phones][0][:number],
      location: []
    }
    #practices
    doctor[:practices].each do |practice|
      location = {
        city: practice[:visit_address][:city],
        state: practice[:visit_address][:state],
        street: practice[:visit_address][:street],
        zip: practice[:visit_address][:zip]
      }
      doctor_hash[:location] << location
    end
    doctor_hash
  end
end
