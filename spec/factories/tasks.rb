FactoryBot.define do
  factory :task do
    name { 'テストを書く'}
    description { 'Rspec&Capybara準備'}
    user
  end
end
