require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @like =  Like.new(user_id: users(:michael).id,
                      user_image_id: user_images(:image1).id)
  end

  test "should valid" do
    assert @like.valid?
  end
  
  test "should require user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should require user_image_id" do
    @like.user_image_id = nil
    assert_not @like.valid?
  end

end
