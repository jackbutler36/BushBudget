require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(first_name: 'Jonas',
                        last_name: 'Stites',
                        street_address: '711 University Dr',
                        street_address_line_two: '1122',
                        city: 'College Station',
                        state: 'TX',
                        zip_code: '77840',
                        phone_number: '(512)332-4558',
                        is_admin: 'no',
                        is_committee_leader: 'yes')
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a street address' do
    subject.street_address = nil
    expect(subject).not_to be_valid
  end

  it 'is valid without a street address two' do
    subject.street_address_line_two = nil
    expect(subject).to be_valid
  end

  it 'is not valid without a city' do
    subject.city = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a state' do
    subject.state = nil
    expect(subject).not_to be_valid
  end

  it 'zip code must be 5 digits' do
    subject.zip_code = '778404'
    expect(subject).not_to be_valid
  end

  it 'zip code must be all numbers' do
    subject.zip_code = '77a40'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a zip code' do
    subject.zip_code = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with an out of range area code' do
    subject.phone_number = '(199)332-4558'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a dash' do
    subject.phone_number = '(199)3324558'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a parenthesis' do
    subject.phone_number = '(199332-4558'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a phone number' do
    subject.phone_number = nil
    expect(subject).not_to be_valid
  end

end
