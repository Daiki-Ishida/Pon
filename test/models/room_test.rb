require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = rooms(:one)
    @user = users(:one)
    @opponent_user = users(:two)
  end

  test "owner_id should be present" do
    @room.owner_id = nil
    assert_not @room.valid?
  end

  test "guest_id should be present" do
    @room.guest_id = nil
    assert_not @room.valid?
  end

  # Opponentメソッド
  test "should return opponent user" do
    assert @room.opponent(@user) == @opponent_user
  end

  # find roomメソッド
  test "should find room from user id" do
    assert Room.find_room(@user.id, @opponent_user.id) == @room
  end
end
