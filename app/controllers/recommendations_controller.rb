class RecommendationsController < ApplicationController
  def add
  end

  def new
    @doctor = Doctor.create(first_name: "Lucy", last_name: "Niflheim")
    @recommendation = Recommendation.new(doctor: @doctor, user: current_user)
    @tags = Tag.default_tags
    @tag = Tag.new
    render :new
  end

  def create
  end

end
