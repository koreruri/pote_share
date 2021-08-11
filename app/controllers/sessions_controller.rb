class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Signed in successfully."
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid Email or password."
      render 'new'
    end
  end
  
  def destroy
  end
end
