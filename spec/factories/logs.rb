FactoryBot.define do
  factory :log do
    content { "醤油はほんとにちょっとだけでOK！" }
    association :dish
  end
end
