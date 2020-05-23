require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "",
                                            user_name: "",
                                            email: "foo@invalid",
                                            web_page: "",
                                            introduce: "",
                                            phone_number: "",
                                            password: "",
                                            password_confirmation: ""}}
    assert_template 'users/edit'
  end

  test "successful edit and delete" do
    get edit_user_path(@user)
    assert_equal edit_user_url(@user), session[:forwarding_url]
    log_in_as(@user)
    assert_nil session[:forwarding_url]
    assert_redirected_to edit_user_url(@user)
    name = "example"
    user_name = "exam"
    gender = 1
    patch user_path(@user), params: {user: {name: name,
                                            user_name: user_name,
                                            email: "rails@example.com",
                                            web_page: "https://www.google.com/",
                                            introduce: "Hello, World",
                                            phone_number: "090-2142-4124",
                                            password: "",
                                            password_confirmation: "",
                                            gender: gender}}
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_equal user_name, @user.user_name
    assert_equal gender, @user.gender
    get edit_user_path(@user)
    assert_select 'a[href=?]', user_path(@user), text: "ユーザー削除"
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
