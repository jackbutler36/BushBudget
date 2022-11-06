require 'rails_helper'

RSpec.describe 'Running user_attendance_history integration tests', type: :feature do
    def login(email, password)
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        click_on 'Log in'
    end

    scenario 'go to user dashboard, and back from user_attendance_history' do
        user = User.new
        user.first_name =  'Test'
        user.last_name =  'User'
        user.street_address = '25 Owl Landing Ln'
        user.street_address_line_two = 'Apt C'
        user.city = 'College Station'
        user.state = 'TX'
        user.zip_code = '77840'
        user.phone_number = '(222)333-4444'
        user.uin = '111222333'
        user.position = 'member'
        user.committee = 'R&D'
        user.email =  'test@gmail.com'
        user.password = '123456'
        user.password_confirmation = '123456'
        user.excusal_date = Date.new(Time.now.year, Time.now.month, Time.now.day)
        user.save!
        visit new_user_session_path
        login('test@gmail.com','123456')
        click_on 'Attendance History'
        click_on 'Dashboard'
        expect(page).to have_content('Dashboard')
        visit attendances_path
        click_on 'Back'
        expect(page).to have_content('Dashboard')
    end
end