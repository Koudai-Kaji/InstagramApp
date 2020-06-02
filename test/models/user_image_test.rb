require 'test_helper'

class UserImageTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @user_image = @user.user_images.build(picture: open("test/fixtures/image1.png", "r"),
                                          name: "picture title")
  end

  test "should be valid" do
    assert @user_image.valid?
  end

  test "user_id shoud be present" do
    @user_image.user_id = nil
    assert_not @user_image.valid?
  end

  test "picture should be present" do
    @user_image.picture = nil
    assert_not @user_image.valid?
  end

  test "user_images shoud have picture" do
    assert @user_image.picture?
  end

  test "order should  be oldest first" do
    assert_equal user_images(:most_recent), UserImage.first
  end

  test "likes method" do
    @like_user = users(:archer)
    @user_image.save
    assert_not @user_image.like_now?(@like_user)
    @user_image.like_you(@like_user)
    assert @user_image.like_now?(@like_user)
    @user_image.unlike_you(@like_user)
    assert_not @user_image.like_now?(@like_user)
  end

  test "name should be presence" do
    @user_image.name = nil
    assert_not @user_image.valid?
  end

  test "name should be under 50" do
    @user_image.name = "a" * 51
    assert_not @user_image.valid?
  end

end
