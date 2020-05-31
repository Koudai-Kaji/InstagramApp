class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @user_image = UserImage.find(params[:user_image_id])
    @user_image.like_you(current_user)
    respond_to do |format|
      format.html {redirect_to (request.referrer || root_url)}
      format.js
    end
  end

  def destroy
    @user_image = Like.find(params[:id]).user_image
    @user_image.unlike_you(current_user)
    respond_to do |format|
      format.html {redirect_to (request.referrer || root_url)}
      format.js
    end
  end

end
