require 'rails_helper'

# Example
RSpec.describe 'Creating a user', type: :feature do
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
  end

  def set_defaults_meeting
    fill_in 'Description', with: 'Meeting about R&D'
    fill_in 'Date', with: Date.new(2022,12,1)
    fill_in 'Password', with: 'goodpassword'
  end

  def new_admin(email, password) # creates new admin account for testing
    admin = Admin.new
    admin.email = email
    admin.password = password
    admin.password_confirmation = password
    admin.save!
  end

  def admin_login(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  scenario 'valid inputs' do # trying to sign in and create user with corrects credentials
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    admin_login('tamubushtest@gmail.com', 'bushboys512')
    click_on 'Users'
    click_on 'New User'
    set_defaults
    fill_in 'Zip code', with: '77840'
    fill_in 'Phone number', with: '(512)774-9949'
    click_on 'Create User'

    visit users_path
    expect(page).to have_content('Jonas')
    expect(page).to have_content('Stites')
    expect(page).to have_content('711 University Dr')
    expect(page).to have_content('1122')
    expect(page).to have_content('College Station')
    expect(page).to have_content('TX')
    expect(page).to have_content('77840')
    expect(page).to have_content('(512)774-9949')
    expect(page).to have_content('123456789')
    expect(page).to have_content('member')
    expect(page).to have_content('R&D')
  end

  scenario 'invalid inputs' do # trying to sign in and create user with incorrect credentials
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    admin_login('tamubushtest@gmail.com', 'bushboys')
    expect(page).to have_no_button 'New User'
  end

  scenario 'meeting with valid credentials' do # creating a meeting with valid admin credentials 
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    admin_login('tamubushtest@gmail.com', 'bushboys512')
    click_on 'Meetings'
    click_on 'New Meeting'
    set_defaults_meeting
    click_on 'Create Meeting'
    visit meetings_path
    
    expect(page).to have_content('Meeting about R&D')
    expect(page).to have_content(Date.new(2022,12,1))
    expect(page).to have_content("goodpassword")
  end

  scenario 'meeting with invalid credentials' do # creating a meeting with invalid admin credentials 
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    admin_login('tamubushtest@gmail.com', 'bushboys')
    expect(page).to have_no_button 'New Meeting'
  end
end
