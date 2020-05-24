require 'test_helper'

class UpdateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "update password" do
    get edit_password_update_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_password_update_path(@user)
    follow_redirect!
    assert_template 'password_updates/edit'
    #current_passwordが無効
    patch password_update_path(@user),  params: {password: "",
                                          user: {password: "password",
                                    password_confirmation: "password"}}
    assert_not flash.empty?
    assert_template 'password_updates/edit'
    #passwordが空欄
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: "",
                                    password_confirmation: ""}}
    assert_template 'password_updates/edit'
    assert_select   'div#error_explanation'
    #passwordが無効
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: "foo",
                                    password_confirmation: "foo"}}
    assert_template 'password_updates/edit'
    assert_select   'div#error_explanation'
    #password_confir_mationの不一致
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: "foobar",
                                    password_confirmation: "foobaz"}}
    assert_template 'password_updates/edit'
    assert_select   'div#error_explanation'
    #passwordの変更成功
    password = "foobar"
    patch password_update_path(@user),  params: {password: "password",
                                          user: {password: password,
                                    password_confirmation: password}}
    user = assigns(:user)
    assert_not flash.empty?
    assert_redirected_to @user
    assert_equal password, user.reload.password
  end

end
