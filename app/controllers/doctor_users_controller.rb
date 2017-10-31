class DoctorUsersController < ApplicationController
  def create
    @doctor = Doctor.find(params[:doctor_id])
  end
end
