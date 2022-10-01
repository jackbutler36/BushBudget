class Meeting < ApplicationRecord
    def validate_date
        if date == nil
            errors.add(:date, 'date cannot be nil')
            return
        end
        if date < Date.today
            errors.add(:date, 'date cannot be before today')
        end
    end

    validates :description, presence: true
    validate :validate_date
    validates :password, presence: true
end
