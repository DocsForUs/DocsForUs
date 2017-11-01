include InsuranceDataHelper

include InsuranceDataHelper

first_name = ["Elizabeth", "Karen", "Michael", "Elesa", "Kevin"]

last_name = ["Blackwell", "Smith", "Mengesha", "Holly"]

specialties = ['optometry', 'primary care', 'therapist', 'dermatologist']

city = ['Atlanta', 'Seattle', 'New York']

state = ['WY', 'NE', 'AZ']

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


User.create(username:'admin', email: ENV['admin_email'], password: ENV['admin_password'], admin: true, superadmin: true)
Tag.destroy_all

safe = ["transgender", "non-binary", "queer", "genderqueer", "trans masculine", "trans feminine", "polyamorous", "asexual", "gay", "lesbian", "bisexual", "pansexual", "latinx", "american indian", "asian", "black", "african american", "middle eastern", "multiracial", "intersex", "a person of color", "female", "male", "two-spirit"]

competencies = ["sex workers", "youth", "teen", "adult", "blind or visually impaired", "deaf or hard hearing", "hiv positive",  "other abled", "cognitive disability", "developmental disability","mental health", "in recovery", "survivors of abuse or trauma", "undocumented", "uninsured", "experiencing addiction", "experiencing homelessness",  "veterans"]

actions = ["asked for pronouns", "used my preferred name", "used my preferred pronouns", "was body positive", "was sex positive", "was fat positive", "respected my partner(s)", "was familiar with my medical concerns", "listened actively", "did not make harmful assumptions", "was up-to-date with current research", "avoided perpetuating stereotypes"]

services = ["hormone therapy", "fertility", "top surgery", "lower surgery", "ffs", "fms", "clitoroplasty", "body sculpting", "breast augmentation", "buttock augmentation", "glansplasty", "hair grafting", "hysterectomy", "labiaplasty", "metoidioplasty", "orchiectomy", "penile implant", "phalloplasty", "scrotoplasty", "tracheal shave", "urethroplasty", "vaginectomy", "vaginoplasty", "reconstructive urology", "cognitive behavioral therapy", "neuro feedback", "acupuncture", "ivf", "endocrinology", "testesterone therapy", "speech therapy", "mental health", "counseling","transition counseling"]

safe.each do |tag|
  Tag.create!(description: tag, default: true, category: "safe")
end

competencies.each do |tag|
  Tag.create(description: tag, default: true, category: "competencies")
end

actions.each do |tag|
  Tag.create(description: tag, default: true, category: "actions")
end

services.each do |tag|
  Tag.create(description: tag, default: true, category: "services")
end
