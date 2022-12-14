# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :recoverable
  # custom validation method for phone number
  def validate_phone_number
    if phone_number.nil?
      errors.add(:phone_number, 'phone number cannot be empty')
      return
    end
    if (phone_number[0] != '(') || (phone_number[1..3].to_i.to_s != phone_number[1..3]) || (phone_number[4] != ')') || (phone_number[5..7].to_i.to_s != phone_number[5..7]) || (phone_number[8] != '-') || (phone_number[9..12].to_i.to_s != phone_number[9..12]) || (phone_number.length != 13)
      errors.add(:phone_number, 'phone number must follow (xxx)xxx-xxxx format')
    end
    if (phone_number[1..3].to_i < 200) || (phone_number[1..3].to_i >= 1000)
      errors.add(:phone_number, 'area code must be between 200-999')
    end
  end
  validates :first_name, :last_name, :street_address, :city, :state, :committee, :excusal_date, presence: true
  validates :zip_code, length: { is: 5 }, numericality: { only_integer: true }, presence: true
  validates :uin, length: { is: 9 }, numericality: { only_integer: true }, presence: true
  validate :validate_phone_number
  validates :position, inclusion: { in: %w[leader member], message: 'only allows leader or member' }, presence: true
end
