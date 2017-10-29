FactoryBot.define do
  factory :recommendation do
    user
    doctor
    review "This is a review hello."
  end
end
