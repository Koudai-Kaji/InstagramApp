require 'test_helper'

class PictureSerchTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "picture serch" do
    log_in_as(@user)
    get root_path
    assert_template "static_pages/home"
    assert_select "input#serch"
    assert_select "input.serch-btn"
    serch = "test"
    get user_images_path, params: {serch: serch}
    assert_template "user_images/index"
    assert_match serch, response.body
    assert_select 'img'
  end

end
