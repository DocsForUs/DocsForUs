class Tag < ApplicationRecord
  has_many :recommendations_tags
  has_many :recommendations, through: :recommendations_tags
  validates :description, :category, :default,  presence: true, uniqueness: true

  def self.default_tags
    Tag.where(default: true)
  end
end
