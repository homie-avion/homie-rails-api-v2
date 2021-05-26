# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ========

#  Create User

require 'json'

# Role.new(name: "user").save
# Role.new(name: "partner").save
# # Role.new(name: "admin").save

# tenant = User.new(username: "tenant", password: "123456", email: "tenant@gmail.com", role_id: Role.find_by(name: "user").id).save
# landlord = User.new(username: "landlord", password: "123456", email: "landlord@gmail.com", role_id: Role.find_by(name: "partner").id).save


# # file = File.read('./properties.json')
# City.new(name: "Quezon City", latitude: 14.6760, longitude: 121.0437).save
# City.new(name: "Makati City", latitude: 12.6760, longitude: 120.0437).save


# Property.new(
#   name: "Makati Lofts", 
#   rent_price: 15000, 
#   length_of_stay: 6, 
#   tenant_count: 20,
#   property_count: 20,
#   status: nil,
#   address: "Poblacion Makati City", 
#   user_id: User.find_by(email: "landlord@gmail.com").id, 
#   city_id: City.find_by(name: "Makati City").id,
# ).save!

# CityPreference.new(
#   user_id: User.find_by(email: "tenant@gmail.com").id, 
#   city_id: City.find_by(name: "Makati City").id, 
# ).save!

CityPreference.new(
  user_id: User.find_by(email: "tenant@gmail.com").id, 
  city_id: City.find_by(name: "Quezon City").id, 
).save!