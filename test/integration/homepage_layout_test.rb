require 'test_helper'

class HomepageLayoutTest < ActionDispatch::IntegrationTest

  test "layouts links" do
    get root_path
    assert_template "static_pages/home"
    assert_select 'a[href=?]', signup_path
    assert_select "a", text: full_title("Home")
  end

end
