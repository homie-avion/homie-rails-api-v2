FactoryBot.define do
  factory :role do
    trait :user_role do
      name {"user"}
    end

    trait :partner_role do
      name {"partner"}
    end

  end
end