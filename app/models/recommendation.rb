class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  has_many :recommendations_tags
  has_many :tags, through: :recommendations_tags
end
