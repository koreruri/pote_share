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
      redirect_to root_url
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
  
  private

  # beforeアクション
  
  #ログイン済みの場合はリダイレクト
  def redirect_logged_in_user
    if logged_in?
      flash[:danger] = "You are already signed in."
      redirect_to root_url
    end
  end
  
  #ログインしていない場合はリダイレクト
  def redirect_not_logged_in
    unless logged_in?
      flash[:danger] = "You are already logged out."
      redirect_to root_url
    end
  end
end
