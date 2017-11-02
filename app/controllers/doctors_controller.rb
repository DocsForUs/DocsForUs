class DoctorsController < ApplicationController
    include StatesHelper
    include SpecialtyDataHelper
    include HTTParty
    include GendersHelper
    include InsuranceDataHelper
    include FormVariablesHelper
    helper_method :current_user

  def find
    @states = helpers.states

    @our_doctors = Doctor.where("first_name LIKE ? AND last_name LIKE ?", "%#{search_params[:first_name]}%", "%#{search_params[:last_name]}%")
    doctor_args = {first_name: search_params[:first_name], last_name: search_params[:last_name],city: search_params[:city].downcase, state: search_params[:state].downcase}

    @api_doctors=Doctor.search_doctor(doctor_args)

    @show_new_doctor = true
    render "recommendations/add"
  end

  def new
    if current_user
      @form_data = helpers.get_variables
      @doctor = Doctor.new
    else
      flash[:alert] = 'You must be logged in to add a doctor'
      redirect_to login_path
    end
  end

  def create
    @doctor = Doctor.find_or_create_by(doctor_params)
    if !@doctor.save
      @errors = @doctor.errors.full_messages
      @form_data = helpers.get_variables
      render :new
    else
      @doctor.insurance(params)
      redirect_to new_recommendation_path(id: @doctor.id)
    end
  end

  def index
    @form_data = helpers.get_variables
    @tags = Tag.all.map {|tag| tag.description}
    page = params[:page]
    per_page = params[:per_page]
    @q = Doctor.ransack(params[:q])
    @doctors = @q.result.includes(:recommendations, :insurances).page(page).per(10)
  end

  def show
    @doctor = Doctor.find(params[:id])
    if @doctor.recommendations.length > 0
      @tags = Tag.joins(:recommendations).where(recommendations: { doctor: @doctor})
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.remove(current_user.id)
    redirect_to root_path
  end

  private

  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address, :phone_number, :street, :city, :state, :zipcode)
  end

end#end of class
