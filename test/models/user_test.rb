require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
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


end
