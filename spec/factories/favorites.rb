FactoryBot.define do
  factory :favorite do
    association :dish
    association :user
  end
end
