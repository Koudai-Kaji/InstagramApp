require 'test_helper'

class PasswordUpdatesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other = users(:archer)
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_password_update_path(@user)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_password_update_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: "foobar",
                                    passowrd_confirmation: "foobar"}}
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other)
    get edit_password_update_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other)
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: "foobar",
                                    passowrd_confirmation: "foobar"}}
    assert flash.empty?
    assert_redirected_to root_url
  end

end
