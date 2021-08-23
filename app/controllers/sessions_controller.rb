class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new, :create]
  before_action :redirect_not_logged_in, only: :destroy
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Signed in successfully."
      redirect_back_or root_url
    else
      flash.now[:danger] = "Invalid Email or password."
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:success] = "Signed out successfully."
    redirect_to root_url
  end
  
end
