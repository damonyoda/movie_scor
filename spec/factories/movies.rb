FactoryBot.define do
  factory :movie do
    sequence(:name) { |n| "Movie Title #{n}" }
    year { 2021 }
    description { "description movie" }
    director { "director movie" }
  end
end