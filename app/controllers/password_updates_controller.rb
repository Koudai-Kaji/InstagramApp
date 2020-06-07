class PasswordUpdatesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def edit
  end

  def update
    if @user && @user.authenticate(params[:password])
      if params[:user][:password] ==  ""
        @user.errors.add(:password, :blank)
        render 'edit'
      elsif @user.update_attributes(user_params)
        flash[:success] = "Password updated!"
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash.now[:danger] = "Invalid password."
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end


end
