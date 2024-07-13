FactoryBot.define do
  factory :review do
    user { "User 1" }
    association :movie, factory: :movie
  end
end
