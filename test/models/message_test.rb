require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @room = rooms(:one)
    @message = Message.create(
      sender_id: @user.id,
      room_id: @room.id,
      content: "テストだよ"
    )
  end

  test "sender_id should be present" do
    @message.sender_id = nil
    assert_not @message.valid?
  end

  test "room_id should be present" do
    @message.room_id = nil
    assert_not @message.valid?
  end

  # create_notification(user, action)メソッド
  test "should create notification" do
    assert_difference 'Notification.count', 1 do
      @message.create_notification(@user, @room)
    end
  end
end
