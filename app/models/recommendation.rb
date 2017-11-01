class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  has_many :recommendations_tags
  has_many :tags, through: :recommendations_tags

  def remove(id)
    user = User.find(id)
    if user.admin
      self.delete
    end
  end
end
