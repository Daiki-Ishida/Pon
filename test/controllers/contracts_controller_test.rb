require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @request = requests(:one)
    @contract = contracts(:one)
    @other_contract = contracts(:two)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Contract.count' do
      post request_contracts_path(@request)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # Request.findがActionDispatch::Requestなるものを参照してしまっている？

  # test "should not create contract by unauthorized person" do
  #   log_in_as(@user)
  #   post request_contracts_path(@request)
  #   assert_not flash.empty?
  #   assert_redirected_to ferrets_path
  # end

  test "should redirect show when not logged in" do
    get contract_path(@contract)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not concerned person" do
    log_in_as(@user)
    get contract_path(@other_contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end
end
