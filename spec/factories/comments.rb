FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "辛くし過ぎたので、次は辛さ控えめにする。" }
    association :dish
  end
end
