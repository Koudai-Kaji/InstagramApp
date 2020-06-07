require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "users profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', @user.user_name
    assert_select 'h1>img.gravatar'
    assert_select 'section', '（プロフィール編集）'
    assert_match @user.user_images.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.user_images.paginate(page: 1).each do |user_image|
      assert_select 'a[href=?]', user_path(user_image.user)
      assert_select 'img'
      assert_select 'input[type=submit]'
    end
  end
end
