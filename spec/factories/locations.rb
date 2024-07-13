FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    country { 'country' }
  end
end
