# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ========

#  Create User

# require 'json'
require 'factory_bot_rails'
require 'faker'

Role.new(name: "user").save
Role.new(name: "partner").save
# Role.new(name: "admin").save

tenant = User.new(username: "tenant", password: "123456", email: "tenant@gmail.com", role_id: Role.find_by(name: "user").id).save
landlord = User.new(username: "landlord", password: "123456", email: "landlord@gmail.com", role_id: Role.find_by(name: "partner").id).save

landlord1 = User.new(username: "landlord1", password: "123456", email: "landlord1@gmail.com", role_id: Role.find_by(name: "partner").id, approved: false).save

cities = City.create([
          {name: "Quezon City", latitude: 14.6760, longitude: 121.0437}, 
          {name: "Makati City", latitude: 14.5547, longitude: 121.0244},
          {name: "Mandaluyong City", latitude: 14.5794, longitude: 121.0359},
          {name: "San Juan City", latitude: 14.6019, longitude: 121.0355},
          {name: "Taguig City", latitude: 14.5176, longitude: 121.0509},
          {name: "Pasig City", latitude: 14.5764, longitude: 121.0851},
          {name: "Marikina City", latitude: 14.6507, longitude: 121.1029},
          {name: "Parañaque City",latitude: 14.4793, longitude: 121.0198},
          {name: "Pasay City", latitude: 14.5378, longitude: 121.0014},
          {name: "Manila City", latitude: 14.5995, longitude: 120.9842}
          ])

rents = Rent.create([
          {name: "Less than 10K Php"},
          {name: "Between 10K to 15K Php"},
          {name: "Between 15K to 20K Php"},
          {name: "20K php and up"},
          {name: "Any"},
          ])

stay_periods  = StayPeriod.create([
          {name: "Up to 6 months"},
          {name: "Maximum of 1 year"},
          {name: "Any"}
        ])

property_type = PropertyType.create([
          {name: "Condominium"},
          {name: "Townhouse"},
          {name: "Dormitory"},
          {name: "Any"},
])


(1..20).each do |id|
  FactoryBot.create(:random_property,
    user_id: [User.find_by(email: "landlord@gmail.com").id, User.find_by(email: "landlord1@gmail.com").id].sample, 
    city_id: City.all.pluck(:id).sample, 
    rent_id: Rent.all.pluck(:id).sample, 
    stay_period_id: StayPeriod.all.pluck(:id).sample, 
    property_type_id: PropertyType.all.pluck(:id).sample
  )
end