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
      end
    
      def login(email, password)
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        click_on 'Log in'
      end
end
