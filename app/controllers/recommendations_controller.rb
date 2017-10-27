class RecommendationsController < ActionController::Base

  def new
    @recommend = Recommendation.new
  end

  def create
    redirect_to '/'
  end

end
