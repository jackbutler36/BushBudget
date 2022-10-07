#the added options are because a new attendance wont be created unless both exist
class Attendance < ApplicationRecord
    belongs_to :user, optional: true, inverse_of: :attendance
    belongs_to :meeting, optional: true, inverse_of: :attendance


end
