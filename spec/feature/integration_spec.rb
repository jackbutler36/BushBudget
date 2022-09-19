require 'rails_helper'

# Example
RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in 'First name', with: 'Jonas'
    fill_in 'Last name', with: 'Stites'
    fill_in 'Street address', with: '711 University Dr'
    fill_in 'Street address line two', with: '1122'
    fill_in 'City', with: 'College Station'
    select 'TX', from: 'State'
    fill_in 'Zip code', with: '77840'
    fill_in 'Phone number', with: '(512)774-9949'
    select 'no', from: 'Is admin'
    select 'yes', from: 'Is committee leader'
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
    expect(page).to have_content('no')
    expect(page).to have_content('yes')
  end
end
