# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  match_id   :bigint(8)
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  setup do
    @match = matches(:content_match)
  end

  test 'team must be invalid' do
    team = Team.new
    refute team.valid?
  end

  test 'team must ve valid' do
    team = Team.new(name: 'Team Rocket', match_id: @match.id)
    assert team.valid?
  end

  test 'team score' do
    skip
    team = teams(:team3)
    user = users(:user_with_team)
    Activity.create(name: 'Ruby as a Day to Day',
                    activity_type: 0,
                    english: false,
                    description: 'The ofician Android Studio IDE',
                    pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                    abstract_outline: 'Intro, getttin-started, activities, MVC',
                    status: 2,
                    score: 25,
                    user: user)
    assert_equal 25, team.score
  end

  test 'retrieves leader team from content match' do
    assert(@match.leader_team.name, 'halcones')
  end

  test 'retrieves top teams from content match' do
    assert(@match.top_teams(2), [teams(:team1), teams(:team2)])
  end
end
