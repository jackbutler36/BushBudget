require 'rails_helper'

# Example
RSpec.describe 'Running integration tests', type: :feature do
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

  scenario 'valid inputs' do # trying to sign in and create user with corrects credentials
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
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
    login('tamubushtest@gmail.com', 'bushboys')
    expect(page).to have_no_button 'New User'
  end

  scenario 'meeting with valid credentials' do # creating a meeting with valid admin credentials 
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
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
    login('tamubushtest@gmail.com', 'bushboys')
    expect(page).to have_no_button 'New Meeting'
  end

  scenario 'attendance with valid credentials' do
    new_user('bushtest@gmail.com', 'pass1234')
    new_meeting(Date.new(2022,12,1), 'pass456')
    new_meeting(Date.new(2022,12,4), 'pass789')
    visit new_attendance_path
    fill_in 'attendance[userNum]', with: '111222333'
    fill_in 'Password', with: 'pass1234'
    click_on 'Create Attendance'
    visit new_user_session_path
    login('bushtest@gmail.com', 'pass1234')
    click_on 'Attendance History'
    expect(page).to have_content(Date.new(2022,12,1))
    expect(page).to have_no_content(Date.new(2022,12,4))
  end

  scenario 'user attendance warning notification' do # creating a used who has 2 missing attendance records and then reducing it to only one
    new_user('bushtest@gmail.com', 'pass1234')
    new_meeting(Date.new(2022,12,1), 'pass456')
    new_meeting(Date.new(2022,12,4), 'pass789')
    new_meeting(Date.new(2022,12,7), 'pass012')
    new_attendance('111222333', 'pass456')
    visit new_user_session_path
    login('bushtest@gmail.com', 'pass1234')
    expect(page).to have_content('WARNING: you have missed')
    new_attendance('111222333', 'pass789')
    visit new_user_session_path
    expect(page).to have_no_content('WARNING: you have missed')
  end

  scenario 'admin attendance warning notification' do # creating a used who has 3 missing attendance records and then reducing it to only two
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    new_user('bushtest@gmail.com', 'pass1234')
    new_meeting(Date.new(2022,12,1), 'pass456')
    new_meeting(Date.new(2022,12,4), 'pass789')
    new_meeting(Date.new(2022,12,7), 'pass012')
    #new_attendance('111222333', 'pass456')
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
    expect(page).to have_content('There are 1 members who\'ve missed 3+ meetings.')
    new_attendance('111222333', 'pass789')
    visit new_admin_session_path
    expect(page).to have_no_content('There are 1 members who\'ve missed 3+ meetings.')
  end

  scenario 'admin viewing attendance of new meeting' do # creating a new meeting and expecting no attendees yet
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    new_user('bushtest@gmail.com', 'pass1234')
    new_user('bushtest2@gmail.com', 'pass12345')
    new_user('bushtest3@gmail.com', 'pass12346')
    new_user('bushtest4@gmail.com', 'pass12347')
    new_meeting(Date.new(2022,12,1), 'pass456')
    #new_attendance('111222333', 'pass456')
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
    click_on 'Meetings'
    click_on 'View Attendees'
    expect(page).to have_no_content('YES')
    new_attendance('111222333', 'pass456')
    click_on 'Back'
    click_on 'View Attendees'
    expect(page).to have_content('YES')
  end

  scenario 'admin viewing attendance of new user' do # creating a new user and expecting no attendances yet
    new_admin('tamubushtest@gmail.com', 'bushboys512')
    new_user('bushtest@gmail.com', 'pass1234')
    new_meeting(Date.new(2022,12,1), 'pass456')
    #new_attendance('111222333', 'pass456')
    visit new_admin_session_path
    login('tamubushtest@gmail.com', 'bushboys512')
    click_on 'Users'
    click_on 'View Profile and Attendance History'
    expect(page).to have_no_content('YES')
    new_attendance('111222333', 'pass456')
    click_on 'Back'
    click_on 'View Profile and Attendance History'
    expect(page).to have_content('YES')
  end

  
end
