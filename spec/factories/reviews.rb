FactoryBot.define do
  factory :review do
    sequence(:user) { |n| "User #{n}" }
    association :movie, factory: :movie
  end
end
