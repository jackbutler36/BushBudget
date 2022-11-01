require 'rails_helper'

RSpec.describe 'Running admin_meeting/edit integration tests', type: :feature do
    def set_defaults # setting parameters without validation for integration testing
        fill_in 'First name', with: 'Jonas'
        fill_in 'Last name', with: 'Stites'
        fill_in 'Street address', with: '711 University Dr'
        fill_in 'Street address line two', with: '1122'
        fill_in 'City', with: 'College Station'
        select 'TX', from: 'State'
        fill_in 'Uin', with: '123456789'
        select 'member', from: 'Position'
        fill_in 'Committee', with: 'R&D'
        fill_in 'Email', with: 'bushtest@gmail.com'
        fill_in 'Password', with: 'pass1234'
        fill_in 'Password confirmation', with: 'pass1234'
        fill_in 'Excusal date', with: Date.new(Time.now.year, Time.now.month, Time.now.day)
      end
    
      def set_defaults_meeting
        fill_in 'Description', with: 'Meeting about R&D'
        fill_in 'Date', with: Date.new(2022,12,1)
        fill_in 'Password', with: 'goodpassword'
      end
    
      def new_meeting(date, password)
        meeting = Meeting.new
        meeting.date = Date.new(2022,12,1)
        meeting.description = 'testing meeting functionality'
        meeting.password = password
        meeting.save!
      end
    
      def new_admin(email, password) # creates new admin account for testing
        admin = Admin.new
        admin.email = email
        admin.password = password
        admin.password_confirmation = password
        admin.save!
      end
    
      def new_attendance(uin, password)
        attendance = Attendance.new
        attendance.userNum = uin
        attendance.password = password
        attendance.save!
      end
    
      def new_user(email, password) # creates new admin account for testing
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
        user.email =  email
        user.password = password
        user.password_confirmation = password
        user.excusal_date = Date.new(Time.now.year, Time.now.month, Time.now.day)
        user.save!
      end
    
      def login(email, password)
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        click_on 'Log in'
      end

      scenario 'go from edit back to dashboard' do # navigating from edit to dashboard admin
        new_admin('tamubushtest@gmail.com', 'bushboys512')
        new_meeting(Date.new(2022,12,1), 'pass456')
        new_meeting(Date.new(2022,12,4), 'pass789')
        new_meeting(Date.new(2022,12,7), 'pass012')
        visit new_admin_session_path
        login('tamubushtest@gmail.com', 'bushboys512')
        click_on 'Meetings'
        click_on 'Edit'
        set_defaults_meeting
        click_on 'Dashboard'
        
        expect(page).to have_content('Admin Dashboard')
       
      end
end