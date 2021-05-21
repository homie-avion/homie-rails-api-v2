FactoryBot.define do
  factory :role do
    trait :tenant do
      name {"tenant"}
    end

    trait :landlord do
      name {"landlord"}
    end

    trait :admin do
      name {"admin"}
    end
  end
end