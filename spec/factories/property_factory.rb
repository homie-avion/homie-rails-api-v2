FactoryBot.define do
  factory :property do
    trait :sample_property do
      name {"Makati Lofts"}
      rent_price {15000}
      tenant_count {20}
      property_count {20}
      bldg_no {"#2"}
      street {"Sample Streeet"}
      barangay {"Sample Barangay"}
      complete_address {"#2, Sample Streeet, Sample Barangay, Makati City"}
    end
  end
end