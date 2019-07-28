require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @other_user_2 = users(:three)
    @contract = contracts(:one)
    @other_contract = contracts(:two)
    @review = reviews(:one)
    @other_review = reviews(:two)
  end

  test "should redirect new when not logged in" do
    get new_contract_review_path(@contract)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when unconcerned user" do
    log_in_as(@other_user_2)
    get new_contract_review_path(@contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect new when unauthorize user" do
    log_in_as(@other_user)
    get new_contract_review_path(@contract)
    assert_not flash.empty?
    assert_redirected_to ferrets_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Review.count' do
      post contract_reviews_path(@contract), params: { review: {content: "テスト",
                                                                rate: 3 } }
    end
    assert_redirected_to login_url
  end

  test "should redirect create when unconcerned user" do
    log_in_as(@other_user_2)
    assert_no_difference 'Review.count' do
      post contract_reviews_path(@contract), params: { review: {content: "テスト",
                                                                rate: 3 } }
    end
    assert_redirected_to ferrets_url
  end

  test "should redirect create when unauthorize user" do
    log_in_as(@other_user)
    assert_no_difference 'Review.count' do
      post contract_reviews_path(@contract), params: { review: {content: "テスト",
                                                                rate: 3 } }
    end
    assert_redirected_to ferrets_url
  end
end
