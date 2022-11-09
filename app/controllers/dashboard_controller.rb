# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @meetings = Meeting.all
    @users = User.all
    @user_attendance = (Attendance.where(userNum: current_user.uin) if current_user)
  end
end
