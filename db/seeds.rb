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
    user = User.new
    user.first_name =  Faker::Name.first_name
    user.last_name =  Faker::Name.last_name
    user.street_address = Faker::Address.street_address
    user.street_address_line_two = Faker::Address.secondary_address
    user.city = Faker::Address.city
    user.state = Faker::Address.state_abbr
    user.zip_code = Faker::Number.between(from: 10000, to: 99950).to_s[0..4]
    user.phone_number = '(' + Faker::Number.between(from: 200, to: 999).to_s[0..2] + ')' + Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s
    user.uin = Faker::Number.number(digits: 9).to_s
    user.position = position
    user.committee = committee
    user.email = Faker::Name.first_name + '@tamu.edu'
    user.password = '123456'
    user.password_confirmation =  '123456'
    user.save!
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

user = User.new
user.first_name =  'Test'
user.last_name =  'User'
user.street_address = '711 uni dr'
user.street_address_line_two = '1320'
user.city = 'College Station'
user.state = 'TX'
user.zip_code = '77840'
user.phone_number = '(222)333-4444'
user.uin = '111222333'
user.position = 'member'
user.committee = 'R&D'
user.email =  'bushuser@tamu.edu'
user.password = '123456'
user.password_confirmation =  '123456'
user.save!
