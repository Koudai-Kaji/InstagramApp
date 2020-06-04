class UserImagesController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :destroy]
  before_action :your_picture,   only: [:destroy]

  def index
    @user_images = UserImage.serch(params[:serch]).paginate(page: params[:page])
  end

  def show
    @user_image  = UserImage.find(params[:id])
    @comment     = @user_image.comments.build
    @comments    = @user_image.comments.paginate(page: params[:page])
  end

  def new
    @user_image = current_user.user_images.build
  end

  def create
    @user_image = current_user.user_images.build(user_image_params)
    if @user_image.save
      flash[:success] = "Your picture uploaded!"
      redirect_to user_image_path(@user_image)
    else
      render 'new'
    end
  end

  def destroy
    @user_image.destroy
    flash[:success] = "Picuture deleted!"
    redirect_to root_url
  end


  private

    #ストロングパラメーター
    def user_image_params
      params.fetch(:user_image, {}).permit(:picture, :name)
    end

    #ストロングパラメーター
    
    #現在のユーザーのpictureのみ取得
    def your_picture
      @user_image = current_user.user_images.find_by(id: params[:id])
      redirect_to root_url if @user_image.nil?
    end


end
