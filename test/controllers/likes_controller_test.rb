require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @other_like = likes(:two)
    @user = users(:one)
    @post = posts(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post post_likes_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect delete when not logged in" do
    assert_no_difference 'Like.count' do
      delete post_likes_path(@post)
    end
    assert_redirected_to login_url
  end
end
