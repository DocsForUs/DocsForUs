class Doctor < ApplicationRecord
  validates :first_name, :last_name, :specialty, :zipcode, presence: true
  validate :email_xor_phone_number
  has_many :recommendations
  has_many :doctors_insurances
  has_many :insurances, through: :doctors_insurances
  has_many :doctors_users
  has_many :users, through: :doctors_users

  def self.search_doctor(doctor)
    response = Doctor.search_api(doctor)
    doctors_array = []
    if response[:data]
      response[:data].each do |doc|
        doctors_array << Doctor.doctor_data(doc)
      end
    end
    doctors_array
  end

  def self.get_insurances(doctor_uid)
    uid = doctor_uid["uid"]
    response = Doctor.insurance_search_api(uid)
    response =  JSON.parse response.body, symbolize_names: true
    insurance_array = []
    if response[:data]
      doc = response[:data]
        insurance_array = Doctor.insurance_data(doc)
    end
   insurance_array
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
    response = HTTParty.get("https://api.betterdoctor.com/2016-03-01/doctors?name=#{full_name}&location=#{location}&limit=10&user_key=#{ENV['BETTER_DOCTOR_USER_KEY']}", format: :plain)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.insurance_search_api(uid)
 HTTParty.get("https://api.betterdoctor.com/2016-03-01/doctors/#{uid}?user_key=#{ENV['BETTER_DOCTOR_USER_KEY']}", format: :plain)
  end

  def self.doctor_data(doctor)
    doctor_hash = {
      first_name: doctor[:profile][:first_name],
      last_name: doctor[:profile][:last_name],
      gender: doctor[:profile][:gender],
      specialty: doctor[:specialties][0][:name],
      phone: doctor[:practices].last[:phones][0][:number],
      uid: doctor[:uid],
      location: [],
      insurances: []

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
    p doctor_hash
  end
  def self.insurance_data(doctor)
    doctor_insurances=[]
    doctor[:insurances].each do |insurance|
      insurance={
        uid: insurance[:insurance_plan][:uid],
        name: insurance[:insurance_plan][:name]
      }
      doctor_insurances << insurance
    end
    doctor_insurances
  end

end#end of class
