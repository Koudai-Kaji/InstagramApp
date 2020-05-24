class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper



  private

    #before action

    #ログイン済みかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url
      end
    end

end
