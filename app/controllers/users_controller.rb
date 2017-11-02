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

  def index
    if current_user.superadmin == false
      redirect_to(root_path)
    end
    @users = User.where("username LIKE ?", "%#{params[:username]}")
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
