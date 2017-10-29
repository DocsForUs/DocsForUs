FactoryBot.define do
  factory :doctor do
    first_name "Georgette"
    last_name "Tronkenheim"
    specialty "Family Practice"
    gender "female"
    street "33 Orange St"
    city "Seattle"
    state "WA"
    zipcode '98103'
    phone_number '2065559999'
    website "cats.com"
    email_address "georgette@doctor.com"
  end
end
