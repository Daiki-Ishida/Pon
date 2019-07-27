require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:one)
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: "テスト" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_comment_path(@comment)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch comment_path(@comment), params: { comment: { content: "TEST" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as other user" do
    log_in_as(@other_user)
    get edit_comment_path(@comment)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when logged in as other user" do
    log_in_as(@other_user)
    patch comment_path(@comment), params: { comment: { content: "TEST" } }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong issuer" do
    log_in_as(@other_user)
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy for wrong comment" do
    log_in_as(@other_user)
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to ferrets_url
  end
end
