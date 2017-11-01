class RecommendationsController < ApplicationController
  include StatesHelper
  include TagsHelper
  def add
    if current_user
      @states = helpers.states
      render :add
    else
      flash.now[:alert] = "You must login or register to recommend a doctor"
      @user = User.new
      render "/users/new"
    end
  end

  def new
    if current_user
      @doctor = Doctor.find(params[:id])
      @recommendation = Recommendation.new(doctor: @doctor, user: current_user)
      @tags = Tag.default_tags
      @tag = Tag.new
      render :new
    else
      flash[:alert] = "You must be logged in to recommend a doctor"
      redirect_to login_path
    end
  end

  def create
    if current_user
      @recommendation = Recommendation.new(rec_params)
      @recommendation.user = current_user
      if !params[:recommendation][:tags]
        @doctor = Doctor.find(params[:recommendation][:doctor_id])
        @tags = helpers.default_tags
        @tag = Tag.new
        @errors = ["You must choose at least one tag."]
        render :new
      else
        tags = params[:recommendation][:tags]
        @recommendation.tags.concat(Tag.tag_sort(tags))
        @recommendation.save
        redirect_to doctor_path(@recommendation.doctor.id)
      end
    else
      redirect_to root_path
    end
  end

  private

  def rec_params
    params.require(:recommendation).permit(:doctor_id, :review)
  end

end
