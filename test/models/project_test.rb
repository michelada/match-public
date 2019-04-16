# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  description  :text
#  repositories :text
#  features     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  match_id     :bigint(8)
#  team_id      :bigint(8)
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @match = matches(:content_match)
    @team = teams(:team2)
    @project = projects(:simple_project)
  end

  test 'Project belongs to a team' do
    assert_equal(@project, @team.projects.first)
    assert_equal(@team, @project.team)
  end
end
