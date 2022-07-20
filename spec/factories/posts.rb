FactoryBot.define do
  factory :post do
    text {'post for like test'}
    association :user
  end
end
