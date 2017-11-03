class RecommendationsController < ApplicationController
  include StatesHelper
  before_action :authorize

  def add
    render :add
  end

  def new
    prepare_doctor(params[:id])
    @recommendation = Recommendation.new(doctor: @doctor, user: current_user)
    render :new
  end

  def create
    @recommendation = Recommendation.new(rec_params)
    @recommendation.user = current_user
    if !params[:recommendation][:tags]
      prepare_doctor(params[:recommendation][:doctor_id])
      @errors = ["You must choose at least one tag."]
      render :new
    else
      tags = params[:recommendation][:tags]
      @recommendation.tags.concat(Tag.tag_sort(tags))
      @recommendation.save
      redirect_to doctor_path(@recommendation.doctor.id)
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
    if current_user == @recommendation.user
      @doctor = @recommendation.doctor
      @tags = Tag.default_tags
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @recommendation = Recommendation.find(params[:id])
    @recommendation.update_attribute('review', rec_updated_params[:review])
    @recommendation.tags.delete_all
    if params[:recommendation][:tags]
      tags = params[:recommendation][:tags]
      @recommendation.tags.concat(Tag.tag_sort(tags))
    end
    @recommendation.save
    redirect_to doctor_path(@recommendation.doctor.id)
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.remove(current_user.id)
    redirect_to root_path
  end

  private

  def prepare_doctor(params)
    @doctor = Doctor.find(params)
    initialize_tags
  end

  def initialize_tags
    @tags = Tag.default_tags
    @tag = Tag.new
  end

  def rec_params
    params.require(:recommendation).permit(:doctor_id, :review)
  end

  def rec_updated_params
    params.require(:recommendation).permit(:review, :tags)
  end

end
