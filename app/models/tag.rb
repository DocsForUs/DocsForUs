class Tag < ApplicationRecord
  has_many :recommendations_tags
  has_many :recommendations, through: :recommendations_tags
  validates :description, presence: true, uniqueness: true
  validates :category, :default, presence: true

  def self.default_tags
    {
      safe: Tag.where(category: "safe").order(:description),
      competencies: Tag.where(category: "competencies").order(:description),
      actions: Tag.where(category: "actions").order(:description),
      services: Tag.where(category: "services").order(:description)
    }
  end
end
