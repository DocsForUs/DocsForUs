module GendersHelper
  include ApplicationHelper
  def genders
    genders = []
      gender  = ["male", "female", "non-binary", "gender neutral", "genderqueer", "transgender", "gender non-conforming"]
      gender.each do |gender|
        genders << Array[gender]
      end
      genders
  end
end
