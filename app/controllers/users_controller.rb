class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :profile, :profile_update, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome! You have signed up successfully."
      redirect_to users_profile_url
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def profile
  end
  
    
  def profile_update
    if @user.update(user_params)
      @user.image.attach(params[:user][:image])
      flash[:success] = "Profile was successfully updated."
      redirect_to users_profile_url
    else
      render 'profile'
    end
  end
  
  def edit
  end
  
  def update
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
                                  :password_confirmation, :image, :introduction)
    end
    
    #beforeアクション
    
    #ログイン済みのユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "You need to sign in or sign up before continuing."
        redirect_to users_sign_in_path
      end
    end
    
    # 現在のユーザーをセットする
    def set_user
      @user = current_user
    end
    
end
