# == Schema Information
#
# Table name: polls
#
#  id         :bigint(8)        not null, primary key
#  start_date :date             not null
#  end_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint(8)
#

require 'test_helper'

class PollTest < ActiveSupport::TestCase
  setup do
    @poll = polls(:poll)
    @team1 = teams(:team1)
  end

  test 'poll return the top score team' do
    register_activities
    team2 = teams(:team2)

    assert_includes  @poll.match.teams_by_score, @team1
    assert_includes  @poll.match.teams_by_score, team2
  end

  test 'poll return the correct winner team' do
    match = matches(:content_match)

    winner_team = teams(:team2)

    assert_equal match.winner_team, winner_team
  end

  test 'obtain last tree activities' do
    match = matches(:content_match)
    ruby = activities(:ruby_as_day_to_day)
    simple_activity = activities(:simple_activity)
    android_studio = activities(:android_studio)
    assert_includes match.last_three_activities, android_studio
    assert_includes match.last_three_activities, ruby
    assert_includes match.last_three_activities, simple_activity
  end

  def register_activities
    simple_activity = activities(:simple_activity)
    simple_activity2 = activities(:simple_activity2)
    simple_activity.update_attributes(score: 1000)
    simple_activity2.update_attributes(score: 800)
  end
end
