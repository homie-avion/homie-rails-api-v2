# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ========

#  Create User

Role.new(name: "tenant").save
Role.new(name: "landlord").save
Role.new(name: "admin").save

tenant = User.new(username: "tenant", password: "123456", email: "tenant@gmail.com", role_id: Role.find_by(name: "tenant").id).save
landlord = User.new(username: "landlord", password: "123456", email: "landlord@gmail.com", role_id: Role.find_by(name: "landlord").id).save