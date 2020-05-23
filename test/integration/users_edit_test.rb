require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
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

  test "successful edit" do
    get edit_user_path(@user)
    name = "example"
    user_name = "exam"
    patch user_path(@user), params: {user: {name: "example",
                                            user_name: "exam",
                                            email: "rails@example.com",
                                            web_page: "https://www.google.com/",
                                            introduce: "Hello, World",
                                            phone_number: "090-2142-4124",
                                            password: "",
                                            password_confirmation: ""}}
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_equal user_name, @user.user_name
  end

end
