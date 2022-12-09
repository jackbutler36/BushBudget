# frozen_string_literal: true

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
  number_users.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.street_address = Faker::Address.street_address
    user.street_address_line_two = Faker::Address.secondary_address
    user.city = Faker::Address.city
    user.state = Faker::Address.state_abbr
    user.zip_code = Faker::Number.between(from: 10_000, to: 99_950).to_s[0..4]
    user.phone_number = '(' + Faker::Number.between(from: 200,
                                                    to: 999).to_s[0..2] + ')' + Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s
    user.uin = Faker::Number.number(digits: 9).to_s
    user.position = position
    user.committee = committee
    user.email = "#{Faker::Name.first_name}@tamu.edu"
    user.password = '123456'
    user.password_confirmation = '123456'
    user.excusal_date = Date.new(Time.now.year, Time.now.month, Time.now.day)
    user.save!
  end
end

def new_user(first, last, uin, email, password)
  user = User.new
  user.first_name = first
  user.last_name = last
  user.street_address = Faker::Address.street_address
  user.street_address_line_two = Faker::Address.secondary_address
  user.city = 'College Station'
  user.state = 'TX'
  user.zip_code = '77840'
  user.phone_number = '(' + Faker::Number.between(from: 200,
                                                  to: 999).to_s[0..2] + ')' + Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s
  user.uin = uin
  user.position = 'member'
  user.committee = 'R&D'
  user.email = email
  user.password = password
  user.password_confirmation = password
  user.excusal_date = Date.new(Time.now.year, Time.now.month, Time.now.day)
  user.save!
end

def new_meeting(date, description, password)
  meeting = Meeting.new
  meeting.date = date
  meeting.description = description
  meeting.password = password
  meeting.save!
end

def new_attendance(uin, password)
  attendance = Attendance.new
  attendance.userNum = uin
  attendance.password = password
  attendance.save!
end

# generate_users(1, 'leader', 'treasury')
# generate_users(1, 'leader', 'R&D')
# generate_users(1, 'leader', 'public relations')
# generate_users(20, 'member', 'treasury')
# generate_users(20, 'member', 'R&D')
# generate_users(20, 'member', 'public relations')

admin = Admin.new
admin.email = 'tamubushtest@gmail.com'
admin.password = 'bushboys512'
admin.password_confirmation = 'bushboys512'
admin.save!
admin = Admin.new
admin.email = 'pack1996@tamu.edu'
admin.password = 'pass1234'
admin.password_confirmation = 'pass1234'
admin.save!
admin = Admin.new
admin.email = 'mupton@tamu.edu'
admin.password = 'password'
admin.password_confirmation = 'password'
admin.save!

new_user('Test', 'User', '111222333', 'bushuser@tamu.edu', '123456')
new_user('Test', 'User2', '222333444', 'bushuser2@tamu.edu', '234567')
new_user('Test', 'User3', '333444555', 'bushuser3@tamu.edu', '345678')
new_user('Test', 'User4', '444555666', 'bushuser4@tamu.edu', '456789')

new_meeting(Date.new(2032, 12, 1), 'R&D scrum', '12345')
new_meeting(Date.new(2032, 12, 4), 'public relations meeting', '34567')
new_meeting(Date.new(2032, 12, 5), 'public relations meeting', '45678')
new_meeting(Date.new(2032, 12, 7), 'committee leaders meet', '67890')
new_meeting(Date.new(2032, 12, 10), 'committee leaders meet 2', '44556')
# initializing test user 1 with only 1 missing meeting, should have no notifications
new_attendance('111222333', '12345')
new_attendance('111222333', '34567')
new_attendance('111222333', '45678')
new_attendance('111222333', '44556')
# initializing test user 2 with 2 missing meetings, should have a personal notification
new_attendance('222333444', '12345')
new_attendance('222333444', '34567')
new_attendance('222333444', '45678')
# initializing test user 3 with 3 missing meetings, should have a personal notification and the admin should be notified
new_attendance('333444555', '12345')
new_attendance('333444555', '34567')
# initializing test user 4 with 3 missing but excused meetings, should have no notifications if setting excuse date to Date.new(2023, 1, 1)
new_attendance('444555666', '12345')
new_attendance('444555666', '34567')
