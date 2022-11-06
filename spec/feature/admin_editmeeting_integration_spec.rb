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
        meeting = Meeting.new
        meeting.date = Date.new(2022,12,1)
        meeting.description = 'testing meeting functionality'
        meeting.password = 'pass123'
        meeting.save!
        visit edit_meeting_path(meeting)
        click_on 'Meetings'
        expect(page).to have_content('Meetings')
        visit edit_meeting_path(meeting)
        click_on 'Users'
        expect(page).to have_content('Users')
        visit edit_meeting_path(meeting)
        click_on 'Dashboard'
        expect(page).to have_content('Dashboard')
        visit edit_meeting_path(meeting)
        fill_in 'Password', with: 'pass1234'
        click_on 'Update Meeting'
        visit meetings_path
        expect(page).to have_content('pass1234')
      end
end
