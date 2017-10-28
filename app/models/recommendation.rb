class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
end
