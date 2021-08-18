class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private

    #ログイン済みのユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "You need to sign in or sign up before continuing."
        redirect_to users_sign_in_path
      end
    end
end
