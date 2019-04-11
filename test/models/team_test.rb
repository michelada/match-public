# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'team must be invalid' do
    team = Team.new
    refute team.valid?
  end

  test 'team must ve valid' do
    team = Team.new(name: 'Team Rocket')
    assert team.valid?
  end

  test 'team score' do
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
end
