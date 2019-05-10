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
    team2 = teams(:team2)
    activity = activities(:activity_post)
    team3 = teams(:team3)
    activity.update_attributes(user: team2.users.first, status: 2)

    assert_includes  @poll.match.teams_by_score, team3
    assert_includes  @poll.match.teams_by_score, team2
  end

  test 'poll return the correct winner team' do
    match = matches(:content_match)

    winner_team = teams(:team2)

    assert_equal match.winner_team, winner_team
  end

  test 'obtain last tree activities' do
    match = matches(:active_content_match)
    ruby = activities(:ruby_as_day_to_day)
    simple_activity = activities(:simple_activity)
    android_studio = activities(:android_studio)
    assert_includes match.last_three_activities, android_studio
    assert_includes match.last_three_activities, ruby
    assert_includes match.last_three_activities, simple_activity
  end
end
