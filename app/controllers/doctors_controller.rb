class DoctorsController < ApplicationController
  def index
  end


  private
  def search_params
    params.require(:doctor).permit(:first_name, :last_name)
  end
end
