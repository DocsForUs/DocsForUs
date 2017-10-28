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
    @recommendation = Recommendation.new(rec_params)
    @recommendation.user = current_user
    tags = params[:recommendation][:tags]
    tags.map! { |tag| TagsController.create(tag)}
    @recommendation.tags << tags
    if @recommendation.save
      redirect_to root_path
    else
      @errors = @recommendation.errors.full_messages
    end
  end

  private

  def rec_params
    params.require(:recommendation).permit(:doctor_id, :review)
  end

end
