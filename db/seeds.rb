require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Faker is a gem for generating random data that helps perform integration testing
def generate_users(number_users, position, committee)
  (number_users).times do
    User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      street_address: Faker::Address.street_address,
      street_address_line_two: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip_code: Faker::Number.between(from: 10000, to: 99950).to_s[0..4],
      phone_number: '(' + Faker::Number.between(from: 200, to: 999).to_s[0..2] + ')' + Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s,
      uin: Faker::Number.number(digits: 9).to_s,
      position: position,
      committee: committee
    )
  end
end

generate_users(1, 'leader', 'treasury')
generate_users(1, 'leader', 'R&D')
generate_users(1, 'leader', 'public relations')
generate_users(20, 'member', 'treasury')
generate_users(20, 'member', 'R&D')
generate_users(20, 'member', 'public relations')

admin = Admin.new
admin.email = 'tamubushtest@gmail.com'
admin.password = 'bushboys512'
admin.password_confirmation = 'bushboys512'
admin.save!
