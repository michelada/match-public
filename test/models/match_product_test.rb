# == Schema Information
#
# Table name: match_products
#
#  id               :bigint(8)        not null, primary key
#  deliverable_id   :integer
#  deliverable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  match_id         :bigint(8)
#

require 'test_helper'

class MatchProductTest < ActiveSupport::TestCase
  def setup
    @match = matches(:content_match)
    @activity = activities(:simple_activity)
    @project = projects(:simple_project)
  end

  test 'can have different deliverables' do
    match_product1 = MatchProduct.new(deliverable: @activity)

    match_product2 = MatchProduct.new(deliverable: @project)

    assert_equal(match_product1.deliverable, @activity)
    assert_equal(match_product2.deliverable, @project)
  end

  test 'belongs to a match' do
    match_product = MatchProduct.new(match: @match)

    assert_equal(match_product.match, @match)
  end
end
