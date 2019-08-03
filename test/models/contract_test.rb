require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  def setup
    @contract = contracts(:one)
  end

  test "owner_id should be present" do
    @contract.owner_id = nil
    assert_not @contract.valid?
  end

  test "sitter_id should be present" do
    @contract.sitter_id = nil
    assert_not @contract.valid?
  end

  test "start_at should be present" do
    @contract.start_at = "   "
    assert_not @contract.valid?
  end

  test "end_at should be present" do
    @contract.end_at = "   "
    assert_not @contract.valid?
  end

  test "fee should be present" do
    @contract.fee = nil
    assert_not @contract.valid?
  end

  test "memo should be present" do
    @contract.memo = nil
    assert_not @contract.valid?
  end
end
