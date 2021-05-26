FactoryBot.define do
  factory :user do
    trait :user1 do
      email {'user@gmail.com'}
      username {'user'}
      password {'123456'}
    end

    trait :partner do
      email {'partner@gmail.com'}
      username {'partner'}
      password {'123456'}
    end

    # trait :broker do
    #   email {'broker@gmail.com'}
    #   username {'broker'}
    #   # role_id buyer_role.id,
    #   password {'123456'}
    #   password_confirmation {'123456'}
    # end

    # trait :admin do
    #   email {'admin@gmail.com'}
    #   username {'admin'}
    #   # role_id buyer_role.id,
    #   password {'123456'}
    #   password_confirmation {'123456'}
    # end
  end
end