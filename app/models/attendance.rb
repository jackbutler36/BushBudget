# frozen_string_literal: true

# the added options are because a new attendance wont be created unless both exist
class Attendance < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :attendance
  belongs_to :meeting, optional: true, inverse_of: :attendance

  def validate_password
    unless Meeting.where(password: password).last
      errors.add(:password, 'meeting password not found')
      nil
    end
  end

  def validate_UIN
    if userNum.nil?
      errors.add(:userNum, 'UIN cannot be blank')
      return
    end
    errors.add(:userNum, 'UIN too short') if userNum.size < 9
    errors.add(:userNum, 'UIN too long') if userNum.size > 9
    unless Attendance.where(userNum: userNum, password: password)
      errors.add(:userNum, 'UIN already entered in this meeting')
    end
    errors.add(:userNum, 'UIN not found') unless User.where(uin: userNum).last
  end

  validate :validate_UIN
  validates :password, presence: true
  validate :validate_password
end
