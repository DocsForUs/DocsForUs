class Insurance < ApplicationRecord
  has_many :doctors_insurances
  has_many :doctors, through: :doctors_insurances
end
