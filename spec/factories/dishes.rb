FactoryBot.define do
  factory :dish do
    name "MyString"
    description "MyText"
    portion 1.5
    tips "MyText"
    reference "MyText"
    required_time 1
    popularity 1
    cook_memo "MyText"
    user nil
  end
end
