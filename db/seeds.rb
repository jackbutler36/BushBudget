require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Faker is a gem for generating random data that helps perform integration testing
25.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    street_address: Faker::Address.street_address,
    street_address_line_two: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: '91934',
    phone_number: '(202)553-7777',
    is_admin: 'yes',
    is_committee_leader: 'no'
  )
end

25.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    street_address: Faker::Address.street_address,
    street_address_line_two: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: '77840',
    phone_number: '(512)774-9949',
    is_admin: 'no',
    is_committee_leader: 'yes'
  )
end
