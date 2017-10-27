class RecommendationsController < ActionController::Base

  def new
    @recommend = Recommendation.new
  end

  def create
    @doctor = Doctor.find_by(full_name: params[:full_name])
    redirect_to '/'
  end

end
