require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full_title_helper" do
    
    assert_equal 'Instagram Clone App', full_title
    assert_equal 'Home | Instagram Clone App', full_title("Home")
    
  end

end