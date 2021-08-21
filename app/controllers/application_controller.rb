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
  
    #ログイン済みの場合はリダイレクト
    def redirect_logged_in_user
      if logged_in?
        flash[:danger] = "You are already signed in."
        redirect_to root_url
      end
    end
    
    #ログインしていない場合はリダイレクト(ログアウトリンク)
    def redirect_not_logged_in
      unless logged_in?
        flash[:danger] = "You are already logged out."
        redirect_to root_url
      end
    end
end
