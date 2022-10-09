class DashboardController < ApplicationController
  def index
    @meetings = Meeting.all
    if current_user
      @user_attendance = Attendance.where(userNum: current_user.uin)
    else
      @user_attendance = nil
    end
  end
end
