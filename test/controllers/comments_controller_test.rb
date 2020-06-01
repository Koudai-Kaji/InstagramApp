require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(comments(:comment1))
    end
    assert_redirected_to login_url
  end

end
