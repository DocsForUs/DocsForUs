class DoctorsController < ApplicationController
    include StatesHelper
    include SpecialtyDataHelper
    include HTTParty
    include GendersHelper
    include TagsHelper
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
      if session[:doctor]
        current_user.doctor = @doctor
        current_user.save
        redirect_to doctor_path(@doctor)
      else
        redirect_to new_recommendation_path(id: @doctor.id)
      end
    end
  end

  def index
    @form_data = helpers.get_variables
    @tags = helpers.tags + Tag.select('description').distinct.map {|tag| tag.description}
    page = params[:page]
    per_page = params[:per_page]
    @q = Doctor.ransack(params[:q])
    @doctors = @q.result.includes(:recommendations, :insurances).page(page).per(10)
  end

  def show
    @doctor = Doctor.find(params[:id])
    @tags = []
    if @doctor.recommendations.length > 0
      @doctor.recommendations.each do |rec|
        rec.tags.each do |tag|
          @tags << tag
        end
      end
      @tags = @tags.uniq
    end
  end

  def edit
    @form_data = helpers.get_variables
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    @doctor.update_attributes(doctor_params)
    redirect_to doctor_path(@doctor)
  end

  private

  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address, :phone_number, :street, :city, :state, :zipcode, :user_id)
  end

end#end of class
