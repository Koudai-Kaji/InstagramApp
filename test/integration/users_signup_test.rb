require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information " do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name:  "",
                                        user_name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "baz"}}
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_match 'The form contains', response.body
  end

  test "valid signup information" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: "Example_user",
                                        user_name: "Example",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    user = assigns(:user)
    assert_redirected_to user
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
