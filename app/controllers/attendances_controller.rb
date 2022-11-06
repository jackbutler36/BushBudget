class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
    @meetings = Meeting.all
    @users = User.all
    if current_user
      @user_attendance = Attendance.where(userNum: current_user.uin)
    end
    @user_first = User.where(uin: @attendances.pluck(:userNum)).first 
    @meet_desc = Meeting.where(password: @attendances.pluck(:password)).first
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      
        if @attendance.save
          format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
          format.json { render :show, status: :created, location: @attendance }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @attendance.errors, status: :unprocessable_entity }
        end
       
    
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:userNum, :password)
    end
end
