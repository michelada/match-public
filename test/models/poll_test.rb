require 'test_helper'

class PollTest < ActiveSupport::TestCase
  setup do
    @poll = polls(:poll)
    @team1 = teams(:team1)
  end

  test 'poll return the top score team' do
    Activity.destroy_all
    create_ruby_activity
    create_android_activity
    team2 = teams(:team2)

    assert_includes  @poll.teams_by_score, @team1
    assert_includes  @poll.teams_by_score, team2
  end

  test 'poll return the correct winner team' do
    Activity.destroy_all
    create_ruby_activity
    create_android_activity

    assert_equal @poll.winner_team, @team1
  end

  test 'obtain last tree activities' do
    create_ruby_activity
    create_android_activity
    @django = Activity.create(name: 'Django',
                              description: 'prueba de Django',
                              pitch_audience: 'prueba de campos requeridos',
                              abstract_outline: 'prueba abstrac',
                              activity_type: 'Curso',
                              english: 0,
                              match_id: 1,
                              status: 0,
                              score: 70,
                              user_id: 187_671)

    assert_includes @poll.last_tree_activities, @android
    assert_includes @poll.last_tree_activities, @ruby
    assert_includes @poll.last_tree_activities, @django
  end

  def create_android_activity
    @android = Activity.create(name: 'Android Studio',
                               description: 'prueba de Android',
                               pitch_audience: 'prueba de campos requeridos',
                               abstract_outline: 'prueba abstrac',
                               activity_type: 'Curso',
                               english: 0,
                               match_id: 1,
                               status: 2,
                               score: 100,
                               user_id: 187_671)
  end

  def create_ruby_activity
    @ruby = Activity.create(name: 'Ruby on Rails',
                            description: 'prueba de Rails',
                            pitch_audience: 'prueba de campos requeridos',
                            abstract_outline: 'prueba abstrac',
                            activity_type: 'Curso',
                            english: 0,
                            score: 20,
                            match_id: 1,
                            status: 2,
                            user_id: 266_512)
  end
end
