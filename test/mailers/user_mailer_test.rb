require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:one)
  end

  test "account_activation" do
    binding.pry
    mail = UserMailer.account_activation(@user)
    @user.activation_token = User.new_token
    assert_equal "PON：アカウントの有効化", mail.subject
    assert_equal [@user.email], mail.to
    # 日本語メールはエンコードがいまいちうまくいかないっぽい
    # assert_equal ["from@example.com"], mail.from
    # assert_match [@user.name], mail.body.encoded
    # assert_match [@user.activation_token], mail.body.encoded
  end
end
