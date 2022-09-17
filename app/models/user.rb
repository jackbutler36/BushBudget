class User < ApplicationRecord
  validates :first_name, :last_name, :street_address, :city, :state, presence: true
  validates :zip_code, numericality: {greater_than: 0, less_than: 99950}, presence: true
  validates :phone_number, length: {is: 10}, presence: true
end
