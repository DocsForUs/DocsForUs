class RecommendationsController < ApplicationController
  include StatesHelper
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
        @tags = Tag.default_tags
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
    if current_user
      @recommendation = Recommendation.find(params[:id])
      @recommendation.update_attribute('review', rec_updated_params[:review])
      @recommendation.tags.delete_all
      if params[:recommendation][:tags]
        tags = params[:recommendation][:tags].map { |tag| Tag.find_or_create_by(description: tag)}
        @recommendation.tags << tags
      end
      @recommendation.save
      redirect_to doctor_path(@recommendation.doctor.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.remove(current_user.id)
    redirect_to root_path
  end

  private

  def rec_params
    params.require(:recommendation).permit(:doctor_id, :review)
  end

  def rec_updated_params
    params.require(:recommendation).permit(:review, :tags)
  end

end
