class User < ApplicationRecord
  def validate_phone_number # custom validation method for phone number
    if phone_number == nil
      errors.add(:phone_number, 'phone number cannot be empty')
      return
    end
    if phone_number[0] != '(' or phone_number[1..3].to_i.to_s != phone_number[1..3] or phone_number[4] != ')' or phone_number[5..7].to_i.to_s != phone_number[5..7] or phone_number[8] != '-' or phone_number[9..12].to_i.to_s != phone_number[9..12] or phone_number.length != 13
      errors.add(:phone_number, 'phone number must follow (xxx)xxx-xxxx format')
    end
    if phone_number[1..3].to_i < 200 or phone_number[1..3].to_i >= 1000
      errors.add(:phone_number, 'area code must be between 200-999')
    end
  end
  validates :first_name, :last_name, :street_address, :city, :state, presence: true
  validates :zip_code, length: { is: 5 }, numericality: {only_integer: true}, presence: true
  validate :validate_phone_number
  validates :is_admin, :is_committee_leader, inclusion: {in: %w(yes no), message: 'only allows yes or no'}, presence: true
end
