# == Schema Information
#
# Table name: matches
#
#  id         :bigint(8)        not null, primary key
#  match_type :integer
#  version    :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  def setup
    @content_match = matches(:content_match)
    @project_match = matches(:project_match)
    @activity = activities(:simple_activity)
    @activity2 = activities(:simple_activity2)
    @project = projects(:simple_project)
  end

  test 'has many match products' do
    deliverable1 = @content_match.match_products.new
    deliverable2 = @content_match.match_products.new

    assert_equal(@content_match.match_products.length, 2)
    assert_equal(@content_match.match_products.first, deliverable1)
    assert_equal(@content_match.match_products.last, deliverable2)
  end

  test 'has many projects through match_products' do
    @content_match.match_products.create(deliverable: @activity)
    @content_match.match_products.create(deliverable: @activity2)

    assert_equal(@content_match.activities.length, 2)
    assert_equal(@content_match.activities.first, @activity)
    assert_equal(@content_match.activities.last, @activity2)
  end
end
