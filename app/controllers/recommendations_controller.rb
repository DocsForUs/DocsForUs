class RecommendationsController < ApplicationController
  def add
  end

  def new
    @doctor = Doctor.create(first_name: "Lucy")
    @recommendation = Recommendation.new(doctor: @doctor, user: current_user)
    render :new
  end

end
