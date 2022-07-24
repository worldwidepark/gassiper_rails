FactoryBot.define do
  factory :like do
    association :user
    association :likable
  end
end
