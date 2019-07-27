require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @room = rooms(:one)
    @other_room = rooms(:two)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Room.count' do
      post rooms_path, params: {guest_id: @other_user.id}
    end
    assert_redirected_to login_url
  end

  test "should redirect create when room already exists" do
    log_in_as(@user)
    assert_no_difference 'Room.count' do
      post rooms_path, params: {guest_id: @other_user.id}
    end
    assert_redirected_to room_url(@room)
  end

  test "should redirect show when not logged in" do
    get room_path(@room)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show for wrong room" do
    log_in_as(@user)
    get room_path(@other_room)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end
end
