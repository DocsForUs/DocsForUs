DEFAULT_TAGS = ["used correct pronouns", "was familiar with my medical needs", "said some stuff and things", "liked cats", "sandwiches"]

class Tag < ApplicationRecord
  has_many :recommendations_tags
  has_many :recommendations, through: :recommendations_tags
  validates :description, :category, :default,  presence: true, uniqueness: true

  def self.default_tags
    default_tags = []
    DEFAULT_TAGS.each do |tag|
      default_tags << Tag.find_by(description: tag)
    end
  end
end
