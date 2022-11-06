require 'rails_helper'

# Example
RSpec.describe 'Running user dashboards integration tests', type: :feature do
    def login(email, password)
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        click_on 'Log in'
    end

      scenario 'go to attendance, dashboard main page' do
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
        login('bushtest@tamu.edu', '123456')
        visit users_path
        click_on 'Dashboard'
        expect(page).to have_content('Dashboard')
        visit new_user_path
        click_on 'Attendance'
        expect(page).to have_content('Attendance')
    end
end