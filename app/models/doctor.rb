class Doctor < ApplicationRecord
  include HTTParty
  validates :first_name, :last_name, :specialty, :zipcode, presence: true
  validate :email_xor_phone_number
  has_many :recommendations
  has_many :doctors_insurances
  has_many :insurances, through: :doctors_insurances
  has_many :doctors_users
  has_many :users, through: :doctors_users

  def remove(id)
    user = User.find(id)
    if user.admin
      self.destroy
    end
  end

  def associate_insurances(uid)
    insurances = Doctor.get_insurances(uid)
    insurances.each do |insurance|
      insurance_database = Insurance.find_by(insurance_uid: insurance[:uid])
      if insurance_database
        self.insurances << insurance_database
      else
        insurance_new = Insurance.create!(insurance_uid: insurance[:uid], insurance_name: insurance[:name])
        self.insurances << insurance_new
      end
      self.save
    end
  end

  private
  def email_xor_phone_number
    if email_address.blank? && phone_number.blank?
      errors.add(:base, "Specify either phone number or email address of the Doctor")
    end
  end

end#end of class
