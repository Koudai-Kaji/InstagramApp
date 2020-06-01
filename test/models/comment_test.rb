require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @comment =  Comment.new(user_id:       users(:michael).id,
                            user_image_id: user_images(:image3).id,
                            body:          "test")
  end

  test "should valid" do
    assert @comment.valid?
  end

  test "should require user_id" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "should require user_image_id" do
    @comment.user_image_id = nil
    assert_not @comment.valid?
  end

  test "should require body" do
    @comment.body = "   "
    assert_not @comment.valid?
  end

  test "body should be 140" do
    @comment.body = "a" * 141
    assert_not @comment.valid?
  end

end
