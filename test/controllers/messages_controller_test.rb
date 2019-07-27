require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @room = Room.create!(owner_id: @user.id, guest_id: @other_user.id)
    @other_room = Room.create!(owner_id: @other_user.id, guest_id: @other_user_2.id)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Message.count' do
      post room_messages_path(@room)
    end
    assert_redirected_to login_url
  end

  test "should redirect create in wrong room" do
    log_in_as(@user)
    assert_no_difference 'Message.count' do
      post room_messages_path(@other_room)
    end
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end


end
