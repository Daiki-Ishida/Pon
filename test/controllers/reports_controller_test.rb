require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @contract = contracts(:one)
    @other_contract = contracts(:two)
    @report = reports(:one)
    @other_reports = reports(:two)
  end

  test "should redirect new when not logged in" do
    get new_contract_report_path(@contract)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when unconcerned user" do
    log_in_as(@other_user_2)
    get new_contract_report_path(@contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect new when unauthorize user" do
    log_in_as(@user)
    get new_contract_report_path(@contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Report.count' do
      post contract_reports_path(@contract), params: { report: {content: "テスト",
                                                                date: "2019-07-28" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect create when unauthorized user" do
    log_in_as(@other_user_2)
    assert_no_difference 'Report.count' do
      post contract_reports_path(@contract), params: { report: {content: "テスト",
                                                                date: "2019-07-28" } }
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect index when not logged in" do
    get contract_reports_path(@contract)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when unauthorized user" do
    log_in_as(@other_user_2)
    get contract_reports_path(@contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect show when not logged in" do
    get contract_report_path(@contract, @report)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when unauthorized user" do
    log_in_as(@other_user_2)
    get contract_report_path(@contract, @report)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect edit when not logged in" do
    get edit_contract_report_path(@contract, @report)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when unconcerned user" do
    log_in_as(@other_user_2)
    get edit_contract_report_path(@contract, @report)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect edit unauthorized user" do
    log_in_as(@user)
    get edit_contract_report_path(@contract, @report)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update when not logged in" do
    patch contract_report_path(@contract, @report), params: { report: {content: "TEST"} }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when unconcerned user" do
    log_in_as(@other_user_2)
    patch contract_report_path(@contract, @report), params: { report: {content: "TEST"} }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect update unauthorized user" do
    log_in_as(@user)
    patch contract_report_path(@contract, @report), params: { report: {content: "TEST"} }
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Report.count' do
      delete contract_report_path(@contract, @report)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when unconcerned user" do
    log_in_as(@other_user_2)
    assert_no_difference 'Report.count' do
      delete contract_report_path(@contract, @report)
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect destroy when unauthorized user" do
    log_in_as(@user)
    assert_no_difference 'Report.count' do
      delete contract_report_path(@contract, @report)
    end
    assert_redirected_to ferrets_url
  end


end
