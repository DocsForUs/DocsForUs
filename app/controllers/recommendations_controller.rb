class RecommendationsController < ActionController::Base

  def new
    @recommend = Recommendation.new
  end

end
