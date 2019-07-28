require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @request = requests(:one)
    @other_request = requests(:two)
  end

  test "should redirect new when not logged in" do
    get new_request_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when request already exist" do
    log_in_as(@user)
    get new_request_path
    assert_not flash.empty?
    # assert_redirected_to edit_request_path(@request)
  end

  test "should redirect new when user do not registered ferret" do
    log_in_as(@other_user_2)
    get new_request_path
    assert_not flash.empty?
    assert_redirected_to new_ferret_path
  end

  test "should redirect create when request already exist" do
    log_in_as(@user)
    assert_no_difference 'Request.count' do
      post requests_path, params: { request: {
        start_at: "2019-07-28",
        end_at: "2019-07-29",
        memo: "テスト",
        fee: 3000,
        sitter_id: 2}}
    end
    assert_not flash.empty?
    # assert_redirected_to edit_request_path(@request)
  end

  test "should redirect create when user do not registered ferret" do
    log_in_as(@other_user_2)
    assert_no_difference 'Request.count' do
      post requests_path, params: { request: {
        start_at: "2019-07-28",
        end_at: "2019-07-29",
        memo: "テスト",
        fee: 3000,
        sitter_id: 1}}
    end
    assert_not flash.empty?
    assert_redirected_to new_ferret_path
  end

  test "should redirect show when not logged in" do
    get request_path(@request)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not concerned person" do
    log_in_as(@user)
    get request_path(@other_request)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect edit when not logged in" do
    get edit_request_path(@request)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when user do not registered ferret" do
    log_in_as(@other_user_2)
    get edit_request_path(@other_request)
    assert_not flash.empty?
    assert_redirected_to new_ferret_path
  end

  test "should redirect edit when not concerned person" do
    log_in_as(@user)
    get edit_request_path(@other_request)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when not logged in" do
    patch request_path(@request), params: { request: { memo: "test" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when user do not registered ferret" do
    log_in_as(@other_user_2)
    patch request_path(@other_request)
    assert_not flash.empty?
    assert_redirected_to new_ferret_path
  end

  test "should redirect update when not concerned person" do
    log_in_as(@user)
    patch request_path(@other_request)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect delete when not logged in" do
    delete request_path(@request), params: { request: { memo: "test" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect delete when user do not registered ferret" do
    log_in_as(@other_user_2)
    assert_no_difference 'Request.count' do
      delete request_path(@other_request)
    end
    assert_not flash.empty?
    assert_redirected_to new_ferret_path
  end

  test "should redirect delete when not concerned person" do
    log_in_as(@user)
    assert_no_difference 'Request.count' do
      delete request_path(@other_request)
    end
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

end
