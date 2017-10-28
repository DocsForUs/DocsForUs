class Tag < ApplicationRecord
  has_many :recommendations_tags
  has_many :recommendations, through: :recommendations_tags
  validates :description, presence: true, uniqueness: true
end
