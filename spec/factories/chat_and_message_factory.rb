FactoryBot.define do
  factory :chat do
    trait :sample_chat do
      success {false}
      user_id {nil}
      partner_id {nil}
      property_id {nil}
    end
  end
end


FactoryBot.define do
  factory :message do
    trait :message1 do
      content {"Hi, when are you available for viewing?"}
    end
    trait :message2 do
      content {"You can visit this coming weekend. Just tell us what time are you going"}
      chat_id {nil}
    end
  end
end