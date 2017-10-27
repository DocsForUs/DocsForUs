class SessionsController < ApplicationController
  def new
    if session[:user_id]
      #redirect to the home page
    end
  end

  def create
    p params
    @user = User.find_by(username: params[:username])
    if @user
      valid = @user.authenticate(params[:password]) #make sure to set the authenticate method in this way in user model.
      if valid
        session[:user_id] = @user.id
        #redirect to the correct page.
      else
        @error = "Invalid credentials"
      end
    else
      @error = "Invalid credentials"
      redirect_to new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to new_session_path
  end
end#end of class
