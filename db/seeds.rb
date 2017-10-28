first_name = ["Elizabeth", "Karen", "Michael", "Elesa", "Kevin"]

last_name = ["Blackwell", "Smith", "Mengesha", "Holly"]

specialties = ['optometry', 'primary care', 'therapist', 'dermatologist']

city = ['Atlanta', 'Seattle', 'New York']

state = ['Wyoming', 'Nebraska', 'Arizona']

20.times do |i|
  Doctor.create(first_name: first_name.sample, last_name: last_name.sample, street: "#{i} Main Street", specialty: specialties.sample, city: city.sample, state: state.sample)
end
