class DoctorUsersController < ApplicationController
  def create
    @doctor = Doctor.find(params[:id])
    current_user.doctors << @doctor
    redirect_to doctor_path(@doctor)
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.users.destroy(current_user)
    redirect_to doctor_path(@doctor)
  end
end
