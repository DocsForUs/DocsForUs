module FormVariablesHelper
  include ApplicationHelper
  include GendersHelper
  include TagsHelper
  include InsuranceDataHelper
  include StatesHelper
  include SpecialtyDataHelper


  def get_variables
    @insurance = get_insurance
    @states = states
    @genders = genders
    @specialties = get_specialties + Doctor.select('specialty').distinct.map {|dr| dr.specialty}
    {insurance: @insurance, states: @states, genders: @genders, specialties: @specialties }
  end
end
