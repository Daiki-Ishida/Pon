require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @wrong_post = posts(:two)
    @issuer = users(:one)
    @wrong_issuer = users(:two)
  end

  test "should redirect new when not logged in" do
    get new_post_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "テスト" } }
    end
    assert_redirected_to login_url
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch post_path(@post), params: { post: { content: "テスト" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong issuer" do
    log_in_as(@wrong_issuer)
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when logged in as wrong issuer" do
    log_in_as(@issuer)
    patch post_path(@wrong_post), params: { post: { content: "テスト" } }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong issuer" do
    log_in_as(@wrong_issuer)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(@wrong_issuer)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to ferrets_url
  end

  test "should get index" do
    get posts_path
    assert_response :success
  end

  test "should redirect territory when not logged in" do
    get territory_posts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect followings when not logged in" do
    get followings_posts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get search" do
    get search_posts_path
    assert_response :success
  end

  test "should get sort" do
    get sort_posts_path, params: { status: 1, sort: "" }
    assert_response :success
  end
end
