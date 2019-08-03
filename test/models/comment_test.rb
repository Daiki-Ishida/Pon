require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "user_id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "post_id should be present" do
    @comment.post_id = nil
    assert_not @comment.valid?    
  end
end
