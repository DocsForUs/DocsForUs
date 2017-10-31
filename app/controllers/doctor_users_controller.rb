class DoctorUsersController < ApplicationController
  def create
    @doctor = Doctor.find(params[:doctor_id])
    current_user.doctors << @doctor
  end
end
