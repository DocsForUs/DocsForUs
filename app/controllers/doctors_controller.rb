class DoctorsController < ApplicationController
    include StatesHelper
    include SpecialtyDataHelper
    include HTTParty
    include GendersHelper
    include TagsHelper
    include InsuranceDataHelper
    helper_method :current_user

  def find
    @states = helpers.states
    p search_params
    p '*' * 50
    p search_params[:first_name]
    @our_doctors = Doctor.where("first_name LIKE ? AND last_name LIKE ?", "%#{search_params[:first_name]}%", "%#{search_params[:last_name]}%")
    doctor_args = {first_name: search_params[:first_name], last_name: search_params[:last_name],city: search_params[:city].downcase, state: search_params[:state].downcase}

    @api_doctors=Doctor.search_doctor(doctor_args)

    @show_new_doctor = true
    render "recommendations/add"
  end

  def new
    if current_user
      @insurance = helpers.get_insurance
      @doctor = Doctor.new
      @states = helpers.states
      @genders = helpers.genders
      @specialties = helpers.get_specialties + Doctor.select('specialty').distinct.map {|dr| dr.specialty}
    else
      flash[:alert] = 'You must be logged in to add a doctor'
      redirect_to login_path
    end
  end

  def create
    insurances = Doctor.get_insurances(insurance_param)
    @doctor = Doctor.find_or_initialize_by(doctor_params)
    insurance = Insurance.find_by(insurance_uid: insurances_param['insurances'])
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
        if insurance
          doc.insurances << insurance
        end
        redirect_to new_recommendation_path(id: @doctor.id)
      else
        @errors = @doctor.errors.full_messages
        render :new
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

  def destroy
    @doctor = Doctor.find(params[:id])
    if params[:user_id].to_i == current_user.id
      current_user.doctors.destroy(@doctor)
    end
    redirect_to doctor_path(@doctor)
  end

  private

  def insurance_asso

  end


  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address, :phone_number, :street, :city, :state, :zipcode)
  end

  def insurance_param
    params.require(:doctor).permit(:uid)
  end


  def insurances_param
    params.require(:doctor).permit(:insurances)
  end


end#end of class
