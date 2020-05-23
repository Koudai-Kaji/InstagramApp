class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Instagram Clone App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end



  
  private

    #ストロングパラメーター
    def user_params
      params.require(:user).permit( :user_name, :name, :email,
                                    :password, :password_confirmation,
                                    :web_page, :introduce, :phone_number,
                                    :gender)
    end

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
