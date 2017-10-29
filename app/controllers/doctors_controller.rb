class DoctorsController < ApplicationController
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

  def index
  end

  def show
  end

  private
  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address,:phone_number,:street,:city,:state,:zipcode)
  end

  def full_search_params
  end

  def specialties_list
    alternative_medicine = {'acupuncturist' => 'Acupuncturist'}
    general = {'primary-care-nurse-practitioner' => 'Primary Care Nurse Practitioner', "primary-care" => "Primary Care"}
    mental_health = {'group-psychotherapy-psychologist' => "Group Psychotherapy Psychologist", 'professional-counselor' => "Professional Counselor", 'psychiatrist' => "Psychiatrist", 'psychiatry-neurology-addiction-medicine' =>  'Psychiatry & Neurology Addiction Medicine', 'health-service-psychologist' => 'Health Service Psychologist', 'addiction-psychiatrist'=> 'Addiction Psychiatrist', 'clinical-psychiatrist'=> 'Clinical Psychiatrist', 'rehabilitation-counselor' => 'Rehabilitation Counselor'}
    cosmetic = ['facial-plastic-surgeon']
    specialties = []
    7a3b4f815a099b84eddd9c78187d4d0d
  end
end
