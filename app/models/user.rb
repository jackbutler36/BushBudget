class User < ApplicationRecord
  validates :first_name, :last_name, :street_address, :city, :state, presence: true
  validates :zip_code, length: {is: 5}, presence: true
  validates :phone_number, length: {minimum: 11, maximum: 15}, presence: true
end
