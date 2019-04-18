require 'test_helper'

class PollTest < ActiveSupport::TestCase
  test 'poll return the top score team' do
    poll = polls(:poll)
    team = teams(:team1)
    Activity.destroy_all
    Activity.create(name: 'Android Studio',
                    description: 'prueba de Android',
                    pitch_audience: 'prueba de campos requeridos',
                    abstract_outline: 'prueba abstrac',
                    activity_type: 'Curso',
                    english: 0,
                    match_id: 1,
                    status: 2,
                    score: 100,
                    user_id: 187_671)

    Activity.create(name: 'Ruby on Rails',
                    description: 'prueba de Rails',
                    pitch_audience: 'prueba de campos requeridos',
                    abstract_outline: 'prueba abstrac',
                    activity_type: 'Curso',
                    english: 0,
                    score: 20,
                    match_id: 1,
                    status: 2,
                    user_id: 266_512)

    assert_equal poll.winner_team, team
  end
end
