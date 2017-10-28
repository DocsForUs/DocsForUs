class DoctorsController < ApplicationController
  def index
    p '*' * 100
    p search_params
    if search_params[:first_name] != "" && search_params[:last_name] != ""
      @doctors = Doctor.where(first_name: search_params[:first_name], last_name: search_params[:last_name])
    end
  end


  private
  def search_params
    params.require(:doctor).permit(:first_name, :last_name)
  end
end
