

class DoctorsController < ApplicationController
    include StatesHelper
    include SpecialtyDataHelper
    include HTTParty
    include GendersHelper
    include TagsHelper

  def find
      @states = helpers.states
    if search_params[:first_name] != "" && search_params[:last_name] != ""
      @our_doctors = Doctor.where(first_name: search_params[:first_name], last_name: search_params[:last_name])
      doctor_args = {first_name: search_params[:first_name], last_name: search_params[:last_name],city: search_params[:city].downcase, state: search_params[:state].downcase}

      @api_doctors=Doctor.search_doctor(doctor_args)

      @show_new_doctor = true
      render "recommendations/add"
    end
  end

  def new
    @doctor = Doctor.new
    @states = helpers.states
    @genders = helpers.genders
    @specialties = helpers.get_specialties + Doctor.select('specialty').distinct.map {|dr| dr.specialty}
  end

  def create
    if params[:user_id]
      @doctor = Doctor.find(params[:doctor_id])
      if current_user.doctors.include?(@doctor)
        redirect_to doctor_path(@doctor)
      else
        current_user.doctors << @doctor
        redirect_to doctor_path(@doctor)
      end
    else
      @doctor = Doctor.new(doctor_params)
      insurances = Doctor.get_insurances(insurance_param)
      if @doctor.save
        doc = Doctor.find(@doctor.id)
        insurances.each do |insurance|
          insurance_database = Insurance.find_by(insurance_uid: insurance[:uid])
          if insurance_database
            doc.insurances << insurance_database
          else
            insurance_new = Insurance.create(insurance_uid: insurance[:uid], insurance_name: insurance[:name])
            doc.insurances << insurance_new
          end
        end
        redirect_to new_recommendation_path(id: @doctor.id)
      else
        @errors = @doctor.errors.full_messages
        render :new
      end
    end
  end

  def index
   @insurance = helpers.get_insurance
   @states = helpers.states
   @genders = helpers.genders
   @specialties = helpers.get_specialties + Doctor.select('specialty').distinct.map {|dr| dr.specialty}
   @tags = helpers.tags + Tag.select('description').distinct.map {|tag| tag.description}


   page = params[:page]
   per_page = params[:per_page]
   @q = Doctor.ransack(params[:q])
   @doctors = @q.result.includes(:recommendations).page(page).per(10)

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

  private


  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address, :phone_number, :street, :city, :state, :zipcode)
  end

  def insurance_param
    params.require(:doctor).permit(:uid)
  end

end#end of class
