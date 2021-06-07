
# cities = ["Quezon City", "Makati city"]
image_number = [2,3].sample
# random_image_no = (1...100).to_a.sample
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

  factory :random_property, class: Property do
    name {Faker::Name.unique.name + "'s Place"}
    tenant_count {Faker::Number.within(range: 1..20)}
    property_count {Faker::Number.within(range: 1..20)}
    bldg_no {"#"+Faker::Number.within(range: 1..20).to_s}
    street {Faker::Name.unique.first_name.to_s + " St."}
    barangay {Faker::Name.unique.last_name.to_s}
    # complete_address {"#2, Sample Streeet, Sample Barangay, Makati City"}
    # complete_address {bldg_no+", "+street+", "+barangay+", "+ cities.sample}
    picture_urls {["https://picsum.photos/640/360.jpg"] * image_number}

    after(:build) do |o, values|
      o.complete_address = values.bldg_no+", "+values.street+", "+values.barangay+", "+ City.find_by(id: values.city_id).name
      o.rent_price  = Faker::Number.within(
        range: (Rent.find_by(id: values.rent_id)[:min].to_i)..(Rent.find_by(id: values.rent_id)[:max].to_i))
    end
  end
end