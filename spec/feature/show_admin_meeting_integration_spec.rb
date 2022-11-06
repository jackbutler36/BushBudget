require 'rails_helper'

# Example
RSpec.describe 'Running admin_meeting/new integration tests', type: :feature do
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
    
    temp_meeting = Meeting.new
    temp_meeting.description = 'R&D scrum'
    temp_meeting.date = Date.new(2022, 12, 01)
    temp_meeting.password = '12345'
    temp_meeting.save!

    visit meetings_path
    click_on 'View Attendees'
    expect(page).to have_content('Meeting')
    click_on 'meeting_btn'
    expect(page).to have_content('Meeting')

    visit meetings_path
    click_on 'View Attendees'
    click_on 'users_btn'
    expect(page).to have_content('First name starts with')

    visit meetings_path
    click_on 'View Attendees'
    click_on 'dashboard_btn'
    expect(page).to have_content('Dashboard')
  end
end
