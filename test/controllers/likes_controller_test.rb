require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  
  test "should redirect create when not logged in" do
    post likes_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete like_path(likes(:like1))
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
