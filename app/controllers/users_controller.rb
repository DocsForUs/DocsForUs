class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @errors = @user.errors.full_messages
      render :new
    end
  end

  def show
    if !current_user
      redirect_to login_path
    elsif current_user.id == params[:id].to_i
      @user = current_user
      render :show
    else
      redirect_to user_path(current_user)
    end
  end

  def check
  end

  def doc_search
    @states = helpers.states
    render :'doctor_form'
  end

  def find
    @states = helpers.states

    @our_doctors = Doctor.where("first_name LIKE ? AND last_name LIKE ?", "%#{search_params[:first_name]}%", "%#{search_params[:last_name]}%")

    @show_new_doctor = true
    render "users/doctor_form"
  end

  def doctor_new
    @user_doctor = User.new
    render "users/new_doctor_user"
  end

  def doctor_signup
    #gets the new doctor form when they dont exist in the database.
    @form_data = helpers.get_variables
    @doctor = Doctor.new
    render "users/new_doc_user_form"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

end
