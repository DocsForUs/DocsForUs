class RecommendationsController < ActionController::Base

  def new
    @recommend = Recommendation.new
  end

  def create

    @doctor = Doctor.find_by(full_name: params[:search])
    if @doctor == nil
      redirect_to new_doctor_path
    end
    redirect_to '/'
  end

end
