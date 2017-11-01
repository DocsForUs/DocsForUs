class Tag < ApplicationRecord
  has_many :recommendations_tags
  has_many :recommendations, through: :recommendations_tags
  validates :description, presence: true, uniqueness: true
  validates :category, presence: true
  validates :default, inclusion: { in: [true, false] }

  def self.default_tags
    {
      safe: Tag.where(category: "safe").order(:description),
      competencies: Tag.where(category: "competencies").order(:description),
      actions: Tag.where(category: "actions").order(:description),
      services: Tag.where(category: "services").order(:description)
    }
  end

  def self.tag_sort(tags)
    custom_tags = []
    existing_tags = []
    return_tags = []
    tags.each do |tag|
      try_tag = Tag.find_by(description: tag)
      if !try_tag
        custom_tags << Tag.create!(description: tag, default: false, category: "custom")
      else
        existing_tags << try_tag
      end
    end
    return_tags.concat(custom_tags)
    return_tags.concat(existing_tags)
    return return_tags
  end
end
