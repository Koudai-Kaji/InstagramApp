require 'test_helper'

class LikeTestTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:michael)
    @user_image = user_images(:image4)
    @like       = likes(:like1)
    log_in_as(@user)
  end
  
  test "should like with standard way" do
    assert_difference 'Like.count', 1 do
      post likes_path, params: {user_image_id: @user_image.id}
    end
  end

  test "shoud like with Ajax" do
    assert_difference 'Like.count', 1 do
      post likes_path, params: {user_image_id: @user_image.id}, xhr: true
    end
  end

  test "should unlike with standard way" do
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
  end

  test "should unlike with Ajax" do
    assert_difference 'Like.count', -1 do
      delete like_path(@like), xhr: true
    end
  end

end
