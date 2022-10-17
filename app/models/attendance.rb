#the added options are because a new attendance wont be created unless both exist
class Attendance < ApplicationRecord
    belongs_to :user, optional: true, inverse_of: :attendance
    belongs_to :meeting, optional: true, inverse_of: :attendance
   
    def validate_password
        if(!Meeting.where(password: self.password).last)
            errors.add(:password, 'meeting password not found')
            return
        end
    end

    def validate_UIN
        if(userNum == nil)
            errors.add(:userNum, 'UIN cannot be blank')
            return
        end    
        if(userNum.size < 9)
            errors.add(:userNum, 'UIN too short')
        end
        if(userNum.size > 9)
            errors.add(:userNum, 'UIN too long')
        end
        if(!Attendance.where(userNum: self.userNum, password: self.password))
            errors.add(:userNum, 'UIN already entered in this meeting')
        end
        if(!User.where(uin: self.userNum).last)
            errors.add(:userNum, 'UIN not found')
        end

    end

    validate :validate_UIN
    validates :password, presence: true
    validate :validate_password

end
