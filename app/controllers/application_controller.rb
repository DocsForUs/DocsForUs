class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StatesHelper
  include FormVariablesHelper

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
      flash.now[:alert] = "You must login or register to recommend a doctor"
      redirect_to login_path unless current_user
  end
end
