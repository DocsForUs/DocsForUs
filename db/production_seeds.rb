class ProductionSeed
  def self.seed_tags
    # CREATE DEFAULT TAGS

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

    puts "Tags have been seeded"
  end

  def self.superadmin(username)
    user = User.find_by(username: username)
    user.superadmin = true
    user.admin = true
    puts "#{username} is now a superadmin"
  end
end
