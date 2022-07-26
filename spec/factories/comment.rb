FactoryBot.define do
  factory :comment do
    text {'comment for like test'}
    association :post
    association :user
  end
end
