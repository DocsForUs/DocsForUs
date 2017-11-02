require_relative '../../db/production_seeds'

namespace :production do
  desc "Seed the production database with tags, etc."
  task seed_tags: :environment do
    ProductionSeed.seed_tags
  end

  desc "Make a user a superadmin."
  task :make_superadmin, [:username] => :environment do |task, args|
    ProductionSeed.superadmin(args[:username])
  end

end
