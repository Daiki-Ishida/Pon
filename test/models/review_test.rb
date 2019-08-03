require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @review = reviews(:one)
  end

  test "rate should be present" do
    @review.rate = nil
    assert_not @review.valid?
  end

  test "comment should be present" do
    @review.comment = "   "
    assert_not @review.valid?
  end

  test "contract_id should be present" do
    @review.contract_id = nil
    assert_not @review.valid?
  end

  # send_noticeメソッド
  test "should create message" do
    assert_difference 'Message.count', 1 do
      @review.send_notice(@user, "create", "test.co.jp")
    end
  end

  # create_contentメソッド
  test "should create content of message" do
    assert @review.create_content("create", "test.co.jp").include?(@review.contract.owner.name)
  end
end
