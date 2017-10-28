class RecommendationsController < ApplicationController
  def add
  end

  def new
    @doctor = Doctor.create(first_name: "Lucy", last_name: "Niflheim")
    @recommendation = Recommendation.new(doctor: @doctor, user: current_user)
    render :new
  end

  def create
  end

end
