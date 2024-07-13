FactoryBot.define do
  factory :movie_actor_location do
    association :movie
    association :actor
    association :location
  end
end
