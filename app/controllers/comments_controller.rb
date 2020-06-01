class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @user_image = UserImage.find(params[:user_image_id])
    @comment    = @user_image.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment success"
      redirect_to user_image_path(@user_image)
    else
      @comments = []
      render 'user_images/show'
    end
  end

  def destroy
    @comment    = current_user.comments.find_by(id: params[:id])
    @user_image = @comment.user_image
    @comment.destroy
    flash[:success] = "Your comment deleted"
    redirect_to @user_image
  end


  private 
  
      #ストロングパラメーター

      def comment_params
        params.require(:comment).permit(:body)
      end

end
