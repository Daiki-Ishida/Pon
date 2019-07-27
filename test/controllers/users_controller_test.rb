require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should get followings" do
    get followings_user_path(@user)
    assert_response :success
  end

  test "should get followers" do
    get followers_user_path(@user)
    assert_response :success
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should redirect territory when not logged in" do
    get territory_users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect followings when not logged in" do
    get followings_users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get search" do
    get search_users_path
    assert_response :success
  end

  test "should get sort" do
    get sort_users_path, params: {status: 1, gender: 2, record: 1, sort:"" }
    assert_response :success
  end

end
