require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @request = requests(:one)
  end

  test "owner_id should be present" do
    @request.owner_id = nil
    assert_not @request.valid?
  end

  test "sitter_id should be present" do
    @request.sitter_id = nil
    assert_not @request.valid?
  end

  test "start_at should be present" do
    @request.start_at = "   "
    assert_not @request.valid?
  end

  test "end_at should be present" do
    @request.end_at = "   "
    assert_not @request.valid?
  end

  test "fee should be present" do
    @request.fee = nil
    assert_not @request.valid?
  end

  test "memo should be present" do
    @request.memo = nil
    assert_not @request.valid?
  end

  # send_noticeメソッド
  test "should create message" do
    assert_difference 'Message.count', 1 do
      @request.send_notice(@user, "create", "test.co.jp")
    end
  end

  # create_contentメソッド
  test "should create content of message" do
    assert @request.create_content("create", "test.co.jp").include?(@request.owner.name)
  end
end
