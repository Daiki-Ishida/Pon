require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @report = reports(:one)
  end

  test "content should be present" do
    @report.content = "   "
    assert_not @report.valid?
  end

  test "data should be present" do
    @report.date = "   "
    assert_not @report.valid?
  end

  test "contract_id should be present" do
    @report.contract_id = nil
    assert_not @report.valid?
  end

  # send_noticeメソッド
  test "should create message" do
    assert_difference 'Message.count', 1 do
      @report.send_notice(@user, "create", "test.co.jp")
    end
  end

  # create_contentメソッド
  test "should create content of message" do
    assert @report.create_content("create", "test.co.jp").include?(@report.contract.sitter.name)
  end
end
