require 'test_helper'

class FerretTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @ferret = ferrets(:one)
    @other_ferret = ferrets(:two)
  end

  test "name should be present" do
    @ferret.name = "     "
    assert_not @ferret.valid?
  end

  test "birth_date should be present" do
    @ferret.birth_date = "     "
    assert_not @ferret.valid?
  end

  test "gender should be present" do
    @ferret.gender = nil
    assert_not @ferret.valid?
  end

  test "user_id should be present" do
    @ferret.user_id = nil
    assert_not @ferret.valid?
  end

  test "should return all ferrets when search window is empty" do
    search = nil
    assert Ferret.search(search) == Ferret.all
  end

  test "should include proper ferrets whene searched" do
    search = "ぽん"
    assert Ferret.search(search).include?(@ferret)
    assert_not Ferret.search(search).include?(@other_ferret)
  end

  test "should find parent" do
    assert @ferret.owned_by?(@user)
  end

  test "siblings should return siblings of the ferret" do
    brother = @user.ferrets.create!(
      name: "弟",
      character: "甘えん坊",
      introduction: "テストだよ",
      birth_date: "2017-08-10",
      gender: 1
    )
    assert @ferret.siblings.include?(brother)
    assert_not @ferret.siblings.include?(@other_ferret)
  end
end
