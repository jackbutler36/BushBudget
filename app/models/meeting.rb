class Meeting < ApplicationRecord
    def validate_attendance
        if date == nil
            errors.add(:date, 'date cannot be nil')
            return
        end
        if date < Date.today
            errors.add(:date, 'date cannot be before today')
        end
        if(!Meeting.where(password: self.password))
            errors.add(:password, ' cant be reused from old meetings')
        end
    end

    validates :description, presence: true
    validate :validate_attendance
    validates :password, presence: true
end
