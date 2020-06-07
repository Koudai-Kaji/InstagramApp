require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user  = users(:michael)
    @other = users(:archer) 
    log_in_as(@user)
  end

  test "should follow a user the standard way" do
    assert_difference 'Relationship.count', 1 do
      post relationships_path, params: {followed_id: @other.id}
    end
  end

  test "should follow a user with Ajax" do
    assert_difference 'Relationship.count', 1 do
      post relationships_path, params: {followed_id: @other.id}, xhr: true
    end
  end

  test "should unfollow a user the standard way" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference 'Relationship.count', -1 do
      delete relationship_path(relationship)
    end
  end

  test "should unfollow a user with Ajax" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference 'Relationship.count', -1 do
      delete relationship_path(relationship), xhr: true
    end
  end

  test "feed on Home page" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'img.gravatar'
    assert_select 'h1', text: @user.user_name
    assert_select 'div.pagination'
    @user.feed.paginate(page: 1).each do |user_image|
      assert_select 'img'
      assert_select 'a[href=?]', user_path(user_image.user)
    end
  end

end
