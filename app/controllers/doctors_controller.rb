class DoctorsController < ApplicationController
  def index
    p '*' * 100
    p search_params
  end


  private
  def search_params
    params.require(:doctor).permit(:first_name, :last_name)
  end
end
