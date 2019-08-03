require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @far_user = User.create!(
          kanji_lastname: "山田",
          kanji_firstname: "花子",
          kana_lastname: "ヤマダ",
          kana_firstname: "ハナコ",
          name: "テストユーザー",
          postal_code: 1234567,
          postal_address: "東京都千代田区千代田１−１",
          introduction: "テストユーザーです。こんにちは。",
          gender: 2,
          birth_date: "1991-05-23",
          latitude: 50,
          longitude: 100,
          territory: 15,
          email: "text@testtest.com",
          password_digest: User.digest('password')
        )
    @post = posts(:one)
    @other_post = posts(:two)
    @far_post = @far_user.posts.create!(
      content: "遠いユーザーだよ"
    )
  end

  # likes?(user)メソッド
  test "should return if the post is liked" do
    assert @post.likes?(@user)
  end

  # Searchメソッド
  test "should return all posts when search window is nil" do
    search = nil
    assert Post.search(search) == Post.all
  end

  test "should include proper user when searched" do
    search = "テスト"
    assert Post.search(search).include?(@post)
    search = "ほげほげ"
    assert_not Post.search(search).include?(@post)
  end

  test "content should be present" do
    @post.content = "     "
    assert_not @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid? 
  end

  # create_notification(user, action)メソッド
  test "should create notification" do
    assert_difference 'Notification.count', 1 do
      @post.create_notification(@other_user, "like")
    end
  end

  # Sort_byメソッド
  test "should return all posts when not sorted" do
    sort = ""
    assert Post.sorted_by(sort, @user) == Post.all
  end

  test "should return posts within territory when sort item is territory" do
    sort = "territory"
    assert_not Post.sorted_by(sort, @user).include?(@far_post)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert Post.sorted_by(sort, @user).include?(@far_post)
  end

  test "should return following users posts when sort item is followings" do
    sort = "followings"
    assert_not Post.sorted_by(sort, @user).include?(@far_post)
    Relationship.create!(followed_id: @far_user.id, follower_id: @user.id)
    assert Post.sorted_by(sort, @user.reload).include?(@far_post)
  end
end
