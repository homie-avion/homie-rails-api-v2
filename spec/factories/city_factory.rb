FactoryBot.define do
  factory :city do
    trait :makati do
      name {"Makati City"}
    end
    trait :quezon do
      name {"Quezon City"}
    end
  end
end