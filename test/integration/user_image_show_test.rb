require 'test_helper'

class UserImageShowTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:michael)
    @user_image = user_images(:image1)
  end
  
  test "userimages_showpage" do
    log_in_as(@user)
    get user_image_path(@user_image)
    assert_template 'user_images/show'
    assert_select 'a[href=?]', user_image_path(@user_image), text: "Delete picture"
    assert_select 'div.pagination'
    @user_image.comments.paginate(page: 1).each do |comment|
      assert_match comment.body, response.body
      if comment.user == @user
        assert_select 'a[href=?]', comment_path(comment), text: "delete", count: 1
      else
        assert_select 'a', text: "dalete", count: 0
      end
    end
    #無効な送信
    assert_no_difference "Comment.count" do
      post comments_path,  params: {user_image_id: @user_image.id,
                                    comment: {body: ""}}
    end
    assert_select 'div#error_explanation'
    #長すぎるコメント
    assert_no_difference "Comment.count" do
      post comments_path,  params: {user_image_id: @user_image.id,
                                    comment: {body: "a" * 150}}
    end
    assert_select 'div#error_explanation'
    #正しいコメント
    body = "Michael Hartl"
    assert_difference 'Comment.count', 1 do
      post comments_path, params: {user_image_id: @user_image.id,
                                  comment: {body: body}}
    end
    comment = assigns(:comment)
    assert_not flash.empty?
    assert_redirected_to user_image_path(@user_image)
    follow_redirect!
    assert_template 'user_images/show'
    assert_match body, response.body
    #コメントを削除する
    assert_difference 'Comment.count', -1 do
      delete comment_path(comment)
    end
    assert_not flash.empty?
  end

end
