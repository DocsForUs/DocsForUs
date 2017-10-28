class RecommendationsTag < ApplicationRecord
  belongs_to :tag
  belongs_to :recommendation
end
