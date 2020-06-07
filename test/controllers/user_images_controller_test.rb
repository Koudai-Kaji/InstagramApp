require 'test_helper'

class UserImagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user_image = user_images(:image1)
    @other_user_image = user_images(:image4)
  end
  
  test "should redirect new when not logged in" do
    get new_user_image_path
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get user_image_path(@user_image)
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'UserImage.count' do
      post user_images_path, params: {user_image: 
                            {picture: open("test/fixtures/image1.png", "r")}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'UserImage.count' do
      delete user_image_path(@user_image)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as users(:michael)
    assert_no_difference 'UserImage.count' do
      delete user_image_path(@other_user_image)
    end
    assert_redirected_to root_url
  end

end
