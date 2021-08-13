class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome! You have signed up successfully."
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    
    if params[:user][:current_password].blank?
      flash.now[:danger] = "現在のパスワードを入力して下さい"
    elsif !@user.authenticate(params[:user][:current_password])
      flash.now[:danger] = "現在のパスワードが正しくありません"
    end
    
    if @user.update(user_params) && !!@user.authenticate(params[:user][:current_password])
      flash[:success] = "Your account has been updated successfully."
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
