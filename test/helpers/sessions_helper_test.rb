require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
  end

  test "current_user returns right user when session is nil" do
    log_in_as(@user)
    assert_equal @user, current_user
    assert logged_in?
    assert current_user?(@user)
  end
end
