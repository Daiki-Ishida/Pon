require 'test_helper'

class UserTest < ActiveSupport::TestCase
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
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "kanji_lastname should be present" do
    @user.kanji_lastname = "     "
    assert_not @user.valid?
  end

  test "kanji_lastname should not be written in Alphabet" do
    @user.kanji_lastname = "ABC"
    assert_not @user.valid?
  end

  test "kanji_firstname should be present" do
    @user.kanji_firstname = "     "
    assert_not @user.valid?
  end

  test "kanji_firstname should not be written in Alphabet" do
    @user.kanji_firstname = "ABC"
    assert_not @user.valid?
  end

  test "kana_lastname should be present" do
    @user.kanji_lastname = "     "
    assert_not @user.valid?
  end

  test "kana_lastname should not be written in Alphabet" do
    @user.kanji_lastname = "ABC"
    assert_not @user.valid?
  end

  test "kana_lastname should not be written in Kanji" do
    @user.kana_lastname = "山田"
    assert_not @user.valid?
  end

  test "kana_lastname should not be written in Hiragana" do
    @user.kana_lastname = "やまだ"
    assert_not @user.valid?
  end

  test "kana_firstname should be present" do
    @user.kana_firstname = "     "
    assert_not @user.valid?
  end

  test "kana_firstname should not be written in Alphabet" do
    @user.kana_firstname = "ABC"
    assert_not @user.valid?
  end

  test "kana_firstname should not be written in Kanji" do
    @user.kana_firstname = "太郎"
    assert_not @user.valid?
  end

  test "kana_firstname should not be written in Hiragana" do
    @user.kana_firstname = "たろう"
    assert_not @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should be within 16 letters" do
    @user.name = "あ" * 17
    assert_not @user.valid?
  end

  test "birth_date should be present" do
    @user.birth_date = "     "
    assert_not @user.valid?
  end

  test "postal_code should be present" do
    @user.postal_code = nil
    assert_not @user.valid?
  end

  test "postal_code should be in 7 numbers" do
    @user.postal_code = 12345678
    assert_not @user.valid?
  end

  test "postal_address should be present" do
    @user.postal_address = "     "
    assert_not @user.valid?
  end

  test "introduction can be nil" do
    @user.introduction = "     "
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@test.com USER@foo.COM U_S-ER@te.st.org
                         us.er@test.jp u+ser@test.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@test,com u_s_e_r.org u.ser@test.
                           user@te_st.jp user@te+st.cn]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated ferrets should be destroyed" do
    # @userはferrets(:one)を持っている。
    assert_difference 'Ferret.count', -1 do
      @user.destroy
    end
  end

  test "associated posts should be destroyed" do
    # @userはposts(:one)を持っている。
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "associated comments should be destroyed" do
    # @userはcomments(:one), (:two)を持っている。
    # さらにcomments(:three)が@userが作ったpost(:one)と
    # 紐づいている。よって3つ消えるべき。
    assert_difference 'Comment.count', -3 do
      @user.destroy
    end
  end

  test "associated likes should be destroyed" do
    assert_difference 'Like.count', -2 do
      @user.destroy
    end
  end

  test "associated active relationship should be destroyed" do
    assert_difference 'Relationship.count', -1 do
      @user.destroy
    end
  end

  test "associated passive relationship should be destroyed" do
    Relationship.create!(
      follower_id: @other_user.id,
      followed_id: @user.id
    )
    assert_difference 'Relationship.count', -2 do
      @user.destroy
    end
  end

  test "should not include the user in other other" do
    assert_not @user.other_users.include?(@user)
  end

  test "should only include users within designated length" do
    assert_not @user.other_users_within(15).include?(@far_user)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert @user.other_users_within(15).include?(@far_user)
  end

  test "should only include users within territory" do
    assert_not @user.objects_within_territory("users").include?(@far_user)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert @user.objects_within_territory("users").include?(@far_user)
  end

  test "should only include ferrets within territory" do
    far_ferret = @far_user.ferrets.build(
      name: "テスト",
      character: "テスト",
      introduction: "テスト",
      birth_date: "2017-08-09",
      gender: 2
    )
    assert_not @user.objects_within_territory("ferrets").include?(far_ferret)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert @user.objects_within_territory("ferrets").include?(far_ferret)
  end

  test "should only include posts within territory" do
    far_post = @far_user.posts.build(
      content: "テスト"
    )
    assert_not @user.objects_within_territory("posts").include?(far_post)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert @user.objects_within_territory("posts").include?(far_post)
  end

  test "should only include following ferrets" do
    ferret = ferrets(:two) # @other_userのフェレット
    assert @user.followings_objects("ferrets").include?(ferret)
    relationship = relationships(:one)
    relationship.destroy
    assert_not @user.reload.followings_objects("ferrets").include?(ferret)
  end

  test "should only include following posts" do
    post = posts(:two) # @other_userの投稿
    assert @user.followings_objects("posts").include?(post)
    relationship = relationships(:one)
    relationship.destroy
    assert_not @user.reload.followings_objects("posts").include?(post)
  end

  # searchメソッドのテスト
  test "should return all users when search window is empty" do
    search = nil
    assert User.search(search) == User.all
  end

  test "should include proper user when searched" do
    search = "テスト"
    assert User.search(search).include?(@user)
  end

  # sorted_byメソッドのテスト
  test "should return all users when not sorted" do
    sort = ""
    assert User.sorted_by(sort, @user) == User.all
  end

  test "should return users within territory when sort item is territory" do
    sort = "territory"
    assert_not User.sorted_by(sort, @user).include?(@far_user)
    @far_user.update!(
      latitude: @user.latitude,
      longitude: @user.longitude
    )
    assert User.sorted_by(sort, @user).include?(@far_user)
  end

  test "should return following users when sort item is followings" do
    sort = "followings"
    assert_not User.sorted_by(sort, @user).include?(@far_user)
    Relationship.create!(followed_id: @far_user.id, follower_id: @user.id)
    assert User.sorted_by(sort, @user).include?(@far_user)
  end

  # has_contracts_as_owner?メソッド
  test "should return boolean depending on whether user has contract as owner" do
    assert @user.has_contracts_as_owner?
    assert_not @far_user.has_contracts_as_owner?
  end

  # contracts_as_ownerメソッド
  test "should return users contracts as owner" do
    contract = contracts(:one)
    other_contract = contracts(:two)
    assert @user.contracts_as_owner.include?(contract)
    assert_not @user.contracts_as_owner.include?(other_contract)
  end

  # has_contracts_as_sitter?メソット
  test "should return boolean depending on whether user has contract as sitter" do
    assert_not @user.has_contracts_as_sitter?
    assert @other_user.has_contracts_as_sitter?
  end

  # contracts_as_sitterメソット
  test "should return users contracts as sitter" do
    contract = contracts(:one)
    other_contract = contracts(:two)
    assert @other_user.contracts_as_sitter.include?(contract)
    assert_not @other_user.contracts_as_sitter.include?(other_contract)
  end
end
