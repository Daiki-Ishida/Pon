require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = relationships(:one)
  end

  test "follower_id should be present" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_id should be present" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
