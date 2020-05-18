require 'test_helper'

class HomepageLayoutTest < ActionDispatch::IntegrationTest

  test "layouts links" do
    get root_path
    assert_template "static_pages/home"
    assert_select 'a[href=?]', signup_path
  end

end
