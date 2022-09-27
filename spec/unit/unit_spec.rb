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
                        uin: '123456789',
                        position: 'member',
                        committee: 'R&D')
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

  it 'must be 9 digits' do
    subject.uin = '1234567890'
    expect(subject).not_to be_valid
  end

  it 'must contain only integers' do
    subject.uin = '12345b789'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a uin' do
    subject.uin = nil
    expect(subject).not_to be_valid
  end

  it 'must be either leader or member' do
    subject.position = 'admin'
    expect(subject).not_to be_valid
  end

  it 'is not valid without a position' do
    subject.position = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a committee' do
    subject.committee = nil
    expect(subject).not_to be_valid
  end

end

RSpec.describe Meeting, type: :model do
  subject do
    described_class.new(description: 'Meeting about R&D',
                        date: Date.new(2022,12,1))
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'cannot have a date before today' do
    subject.date = Date.new(2022,6,1)
    expect(subject).not_to be_valid
  end

  it 'date cannot be null' do
    subject.date = nil
    expect(subject).not_to be_valid
  end

  it 'description cannot be null' do
    subject.description = nil
    expect(subject).not_to be_valid
  end
end
