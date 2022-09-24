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

  def new_admin(email, password) # creates new admin account for testing
    admin = Admin.new
    admin.email = email
    admin.password = password
    admin.password_confirmation = password
    admin.save!
  end

  scenario 'valid inputs' do # trying to sign in and create user with corrects credentials
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    #click_on 'Login'
    fill_in 'Email', with: 'tamubushtest@gmail.com'
    fill_in 'Password', with: 'bushboys512'
    click_on 'Log in'
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
    #click_on 'Login'
    fill_in 'Email', with: 'tamubushtest@gmail.com'
    fill_in 'Password', with: 'bushboys'
    click_on 'Log in'
    expect(page).to have_no_link 'New User'
  end
end
