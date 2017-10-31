class DoctorUsersController < ApplicationController
  def create
    @doctor = Doctor.find(params[:doctor_id])
    current_user.doctors << @doctor
    redirect_to doctor_path(@doctor)
  end

  def destroy
    @doctor = Doctor.find(params[:id])
  end
end
