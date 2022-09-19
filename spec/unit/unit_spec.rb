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

  it 'is not valid without a city' do
    subject.city = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a state' do
    subject.state = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a zip code' do
    subject.zip_code = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a phone number' do
    subject.phone_number = nil
    expect(subject).not_to be_valid
  end
end
