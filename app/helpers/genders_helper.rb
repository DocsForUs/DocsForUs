module GendersHelper
  include ApplicationHelper
  def genders
    genders = []
      gender  = %w(male female non-binary, neutral, genderqueer, transgender, rather not say, gender non-conforming, unsure)
      gender.each do |gender|
        genders << Array[gender]
      end
      genders
  end
end
