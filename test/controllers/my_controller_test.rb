require 'test_helper'

class MyControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should redirect my-page when not logged in" do
    get my_page_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-territory when not logged in" do
    get my_territory_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-update-territory when not logged in" do
    patch my_update_territory_path, params: { user: { territory: 20 } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-settings when not logged in" do
    get my_settings_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-ferrets when not logged in" do
    get my_ferrets_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-posts when not logged in" do
    get my_posts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-notifications when not logged in" do
    get my_notifications_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-contracts when not logged in" do
    get my_contracts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my-update-status when not logged in" do
    patch my_update_status_path, params: { user: { status: 2 } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
