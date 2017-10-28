class DoctorsController < ApplicationController
  def index
  end
  
  def show
    @Doctor = Doctor.find(params[:id])
  end


  private
  def search_params
    params.require(:doctor).permit(:first_name, :last_name)
  end
end
