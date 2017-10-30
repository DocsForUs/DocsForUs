include InsuranceDataHelper

first_name = ["Elizabeth", "Karen", "Michael", "Elesa", "Kevin"]

last_name = ["Blackwell", "Smith", "Mengesha", "Holly"]

specialties = ['optometry', 'primary care', 'therapist', 'dermatologist']

city = ['Atlanta', 'Seattle', 'New York']

state = ['Wyoming', 'Nebraska', 'Arizona']

20.times do |i|
  Doctor.create(first_name: first_name.sample, last_name: last_name.sample, street: "#{i} Main Street", specialty: specialties.sample, city: city.sample, state: state.sample, email_address:"dr@doctor.com", zipcode: "09099")
end

Doctor.create(first_name: 'Eliza', last_name: "Brine", street: "1 Main Street", specialty: specialties.sample, city: 'Northport', state: "NY", email_address:"dr@doctor.com", zipcode: "09099")
Doctor.create(first_name: 'Eliza', last_name: "Brine", street: "1 Main Street", specialty: specialties.sample, city: 'New York', state: "NY", email_address:"dr@doctor.com", zipcode: "09099")
Doctor.create(first_name: 'Eliza', last_name: "Brine", street: "1 Main Street", specialty: specialties.sample, city: 'Syracuse', state: "NY", email_address:"dr@doctor.com", zipcode: "09099")

insurances = InsuranceDataHelper.get_insurance
insurances.length.times do |i|
  ins = Insurance.create(insurance_uid: insurances[i][1], insurance_name: insurances[i][0])
  Doctor.all.sample.insurances << ins
end
