class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "Your email or password is incorrect"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end#end of class
