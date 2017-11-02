class UsersController < ApplicationController
  helper_method :current_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
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

  def index
    if !current_user || !current_user.superadmin
      redirect_to(root_path)
    end
    if params[:usernames]
      @users = User.where("username LIKE ?", "%#{admin_params[:username]}")
    end
    @admins = User.where(admin: true)
  end

  def update
    @user = User.find(params[:id])
    if @user.admin == false
      @user.make_admin(current_user)
    else
      @user.remove_admin(current_user)
    end
    redirect_to users_path
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

  def doctor_create
    @user_doctor = User.new(user_params)
    if @user_doctor.save
      session[:user_id] = @user_doctor.id
      session[:doctor] = true
      redirect_to doctor_signup_path
    else
      @errors = @user_doctor.errors.full_messages
      render :new
    end
  end

  def doctor_signup
    #gets the new doctor form when they dont exist in the database.
    @form_data = helpers.get_variables
    @doctor = Doctor.new
    render "new_doc_user_form"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def admin_params
    params.require(:usernames).permit(:username)
  end

  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

end
