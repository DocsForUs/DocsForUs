class RecommendationsController < ActionController::Base

  def new
    @recommend = Recommendation.new
  end

  def create

    @doctor = Doctor.find_by(full_name: params[:search])
    if @doctor == nil
      p '*' * 40
      return new_doctor_path
    else
      return '/'
    end
  end

end
