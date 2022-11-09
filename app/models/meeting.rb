# frozen_string_literal: true

class Meeting < ApplicationRecord
  def validate_attendance
    if date.nil?
      errors.add(:date, 'date cannot be nil')
      return
    end
    errors.add(:date, 'date cannot be before today') if date < Date.today
    errors.add(:password, ' cant be reused from old meetings') unless Meeting.where(password: password)
  end

  validates :description, presence: true
  validate :validate_attendance
  validates :password, presence: true
end
