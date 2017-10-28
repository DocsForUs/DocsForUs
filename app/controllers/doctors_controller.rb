class DoctorsController < ApplicationController
    include HTTParty
  def index
    if search_params[:first_name] != "" && search_params[:last_name] != ""
      @doctors = Doctor.where(first_name: search_params[:first_name], last_name: search_params[:last_name])
      render "recommendations/add"
    end
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to doctor_path(@doctor)
    else
      @errors = @doctor.errors.full_messages
      render :new
    end
  end

  def show
  end

  private


  def search_params
   params.require(:doctor).permit(:first_name, :last_name)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address,:phone_number,:street,:city,:state,:zipcode)
  end
end#end of class
