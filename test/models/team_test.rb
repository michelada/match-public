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
    team = Team.new(name: 'Team Rocket', match: @match)
    assert team.valid?
  end

  test 'team can obytain the total score' do
    team = teams(:team3)
    user = users(:user_with_team)

    Activity.create(name: 'Ruby as a Day to Day',
                    activity_type: 0,
                    english: false,
                    description: 'The oficial Android Studio IDE',
                    pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                    abstract_outline: 'Intro, getttin-started, activities, MVC',
                    status: 2,
                    match: @match,
                    user: user)
    assert_equal 40, team.score
  end

  test 'retrieves leader team from content match' do
    assert(@match.leader_team.name, 'halcones')
  end

  test 'retrieves top teams from content match' do
    actividad = activities(:ruby_as_day_to_day)
    simple_activity = activities(:simple_activity2)
    user2 = users(:user2_in_match)

    actividad.update_attributes(score: 40, status: 2)
    simple_activity.update_attributes(user: user2, score: 10, status: 2)

    assert_includes(@match.top_teams(2), teams(:team4))
    assert_includes(@match.top_teams(2), teams(:team2))
    assert(@match.top_teams(2), [teams(:team4), teams(:team2)])
  end
end
