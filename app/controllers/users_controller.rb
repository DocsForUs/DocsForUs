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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def admin_params
    params.require(:usernames).permit(:username)
  end

end
