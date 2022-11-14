# frozen_string_literal: true

require 'rails_helper'

# Example
RSpec.describe 'Running admin_meeting/edit integration tests', type: :feature do
  def login(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  scenario 'go to meetings, users, dashboard main page' do
    admin = Admin.new
    admin.email = 'tamubushtest@gmail.com'
    admin.password = 'bushboys512'
    admin.password_confirmation = 'bushboys512'
    admin.save!
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
    user = User.new
    user.first_name = 'Test'
    user.last_name = 'User'
    user.street_address = '711 uni dr'
    user.street_address_line_two = '1320'
    user.city = 'College Station'
    user.state = 'TX'
    user.zip_code = '77840'
    user.phone_number = '(222)333-4444'
    user.uin = '111222333'
    user.position = 'member'
    user.committee = 'R&D'
    user.email =  'test@gmail.com'
    user.password = 'abcdefg'
    user.password_confirmation = 'abcdefg'
    user.excusal_date = Date.new(Time.now.year, Time.now.month, Time.now.day)
    user.save!
    click_on 'Users'
    click_on 'View Profile and Attendance History'
    click_on 'Meetings'
    expect(page).to have_content('Meetings')
  end
end
