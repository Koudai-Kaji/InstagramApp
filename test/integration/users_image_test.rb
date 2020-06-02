require 'test_helper'

class UsersImageTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other = users(:archer)
  end

  test "picture upload and delete" do
    log_in_as(@user)
    get new_user_image_path
    assert_template 'user_images/new'
    assert_select 'input[type=file]'
    #無効な送信
    post user_images_path, params: {user_image: {picture: ""}}
    assert_select 'div#error_explanation'
    #有効な送信
    picture = fixture_file_upload("test/fixtures/image1.png", 'image/png')
    name = "picture name"
    assert_difference 'UserImage.count', 1 do
      post user_images_path, params: {user_image: {picture: picture, name: name}}
    end
    user_image = assigns(:user_image)
    assert_not flash.empty?
    assert_redirected_to user_image_path(user_image)
    follow_redirect!
    assert_template 'user_images/show'
    assert_select "h2", name
    assert_select "img"
    assert_select "a", text: "Delete picture"
    assert_difference 'UserImage.count', -1 do
      delete user_image_path(user_image)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "Access show as wrong user" do
    log_in_as(@user)
    picture = fixture_file_upload("test/fixtures/image1.png", 'image/png')
    post user_images_path, params: {user_image: {picture: picture, name: @user.name}}
    user_image = assigns(:user_image)
    delete logout_path(@user)
    log_in_as(@other)
    get user_image_path(user_image)
    assert_select "img"
    assert_select "a", text: "Delete picture", count: 0
  end

end
