require 'test_helper'

class FerretsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @ferret = ferrets(:one)
    @wrong_ferret = ferrets(:two)
    @owner = users(:one)
    @wrong_owner = users(:two)
  end

  test "should redirect new when not logged in" do
    get new_ferret_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Ferret.count' do
      post ferrets_path, params: { ferret: { name: "テスト",
                                             character: "テスト",
                                             introduction: "テストだよ",
                                             birth_date: "2017-10-20",
                                             gender: 1} }
    end
    assert_redirected_to login_url
  end

  test "should get show" do
    get ferret_path(@ferret)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_ferret_path(@ferret)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch ferret_path(@ferret), params: { ferret: { name: "テスト",
                                                    character: "テスト",
                                                    introduction: "テストだよ",
                                                    birth_date: "2017-10-20",
                                                    gender: 1} }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong owner" do
    log_in_as(@wrong_owner)
    get edit_ferret_path(@ferret)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when logged in as wrong owner" do
    log_in_as(@owner)
    patch ferret_path(@wrong_ferret), params: { ferret: { name: "テスト",
                                                          character: "テスト",
                                                          introduction: "テストだよ",
                                                          birth_date: "2017-10-20",
                                                          gender: 1 } }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Ferret.count' do
      delete ferret_path(@ferret)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong owner" do
    log_in_as(@wrong_owner)
    assert_no_difference 'Ferret.count' do
      delete ferret_path(@ferret)
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy for wrong ferret" do
    log_in_as(@wrong_owner)
    assert_no_difference 'Ferret.count' do
      delete ferret_path(@ferret)
    end
    assert_redirected_to ferrets_url
  end

  test "should get index" do
    get ferrets_path
    assert_response :success
  end

  test "should redirect territory when not logged in" do
    get territory_ferrets_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect followings when not logged in" do
    get followings_ferrets_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get search" do
    get search_ferrets_path
    assert_response :success
  end

  test "should get sort" do
    get sort_ferrets_path, params: {status: 1, gender: 2, range: "1才〜３才", sort: "" }
    assert_response :success
  end
end
