require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
    @ferret = ferrets(:one)
    @contract = contracts(:one)
  end

  test "display_name returns name with proper suffix" do
    assert display_name(@user) == "#{@user.name} さん"
    assert display_name(@ferret) == "#{@ferret.name} くん"
  end

  test "display_age returns approximate age or age depending on model" do
    @user.birth_date = Date.today.prev_year(25).prev_month(5)
    @ferret.birth_date = Date.today.prev_year(3)
    assert display_age(@user) == "20代"
    assert display_age(@ferret) == "3 才"
  end

  test "dislplay_address returns within city name" do
    assert display_address(@user) == "東京都千代田区"
    assert display_address(@user) == display_address(@ferret)
  end

  test "display_gender returns gender in proper word" do
    assert display_gender(@user) == "女性"
    assert display_gender(@ferret) == "オス"
  end

  test "display_period returns period of contract" do
    assert display_period(@contract) == "2019年07月28日から2019年07月29日までの1泊2日"
  end
end
