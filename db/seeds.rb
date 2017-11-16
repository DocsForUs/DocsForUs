

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



insurance_list = ["Advantage Health Solutions", "Aetna", "Altius Coventry Health Care", "Ambetter Superior Health Plan", "Amerihealth", "Ameritas", "Anthem", "Assurant", "Aultcare", "BCBS Blue Card", "BCBS Minnesota", "Blue Cross Blue Sheild of Alabama", "Blue Cross Blue Shield of Aritona", "Blue Cross Blue Shield of Florida", "Blue Cross Blue Shield of Florida BCBSFL", "Blue Cross Blue Shield of Georgia", "Blue Cross Blue Shield of Illinois", "Blue Cross Blue Shield of Kansas City", "Blue Cross Blue Shield of Louisiana", "Blue Cross Blue Shield of Massachusetts", "Blue Cross Blue Shield of Michigan", "Blue Cross Blue Shield of New Mexico", "Blue Cross Blue Shield of Oklahoma", "Blue Cross Blue Shield of Rhode Island", "Blue Cross Blue Shield of TX", "Blue Cross Blue Shield of Tennessee", "Blue Cross Blue Shield of Texas", "Blue Cross Blue Shield of Texas BCBSTX", "Blue Cross Blue Shield of Wyoming", "Blue Cross Idaho", "Blue Shield of California", "Bluegrass Family Health", "Bridgespan", "Buckeye Community Health Plan", "Capital Blue Cross", "Capital District Physicians Health Plan", "Care First Blue Cross Blue Shield", "Chinese Community Health Plan", "Cigna", "Cigna Dental", "Cofinity", "CommUnityCare Health Centers", "CompBenefits Corporation", "Connecticare", "Coventry Health Care", "Delta Dental", "Dental Network of America", "DenteMax", "Diversified Dental", "Dominion Group", "Emblem Health", "Empire BCBS", "Excellus BCBS", "First Choice", "First Dental Health", "First Health Coventry Healthcare", "GWH-Cigna", "Geisinger Health Plan", "Group Health Cooperative", "Guardian Dental", "Gundersen Health Plan", "HAP", "HIP of NY", "HMSA", "Harvard Pilgrim", "Health Alliance", "Health Net", "Health Plan of Nevada", "HealthFirst NY", "HealthLink", "HealthNow", "HealthPlus of Michigan", "HealthSpan", "Highmark Blue Cross Blue Shield", "Home State Health Plan", "Horizon BCBS", "Humana", "IBC  Amerihealth", "Independence Blue Cross", "Independent Health Association", "Kaiser - MidAtlantic", "Kaiser Permanente", "L.A. Care Health", "Liberty Dental Plan", "Lifewise health Plan of Oregon", "MHS Indiana", "MHealth Insured", "MVP Health Plan", "MagnaCare", "Medicaid", "Medical Mutual of Ohio", "Medicare", "MetLife", "Molina Healthcare", "Multiplan", "ODS Health Plan", "Oxford Health", "PacificSource Health Plans", "Paramount", "Premera Blue Cross", "Premera Blue Cross Blue Shield", "Presbyterian Healthcare Services", "Principal Financial Services", "PriorityHealth", "Providence Health System", "QualCare", "Qualchoice", "Regence Blue Cross Blue Shield of Oregon", "Regence Blue Cross Blue Shield of Utah", "Regence Blue Shield of Idaho", "Regence Blue Shield of Washington", "Rocky Mountain Health Plans", "Sagamore Health Network", "Scion Dental", "Scott and White", "Sharp Health Plan", "Sierra Health", "Spectrum Health", "Total Dental Administrators", "Total Health Plan", "Tufts Health Plan", "UHC West Formerly Pacificare", "UHC of the River Valley", "United Concordia", "United Healthcare", "United Healthcare Dental", "Unity Health Insurance", "VSP", "Wellmark Blue Cross and Blue Shield", "Western Health Advantage", "Wisconsin Physicians Service Insurance Corporation"]

insurance_list.each do |insurance|
  ins = Insurance.create(insurance_name: insurance)
  Doctor.all.sample.insurances << ins
end

User.create(username:'admin', email: ENV['admin_email'], password: ENV['admin_password'], admin: true, superadmin: true)
Tag.destroy_all

safe = ["transgender", "non-binary", "queer", "genderqueer", "trans masculine", "trans feminine", "polyamorous", "asexual", "gay", "lesbian", "bisexual", "pansexual", "latinx", "american indian", "asian", "black", "african american", "middle eastern", "multiracial", "intersex", "a person of color", "female", "male", "two-spirit"]

competencies = ["sex workers", "youth", "teen", "adult", "blind or visually impaired", "deaf or hard hearing", "hiv positive",  "other abled", "cognitive disability", "developmental disability","mental health", "in recovery", "survivors of abuse or trauma", "undocumented", "uninsured", "experiencing addiction", "experiencing homelessness",  "veterans"]

actions = ["asked for pronouns", "used my preferred name", "used my preferred pronouns", "was body positive", "was sex positive", "was fat positive", "respected my partners", "was familiar with my medical concerns", "listened actively", "did not make harmful assumptions", "was up-to-date with current research", "avoided perpetuating stereotypes"]

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
