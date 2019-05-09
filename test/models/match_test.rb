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
  setup do
    @project_match = matches(:empty_project_match)
    @content_match = matches(:empty_content_match)
  end

  test 'matches can have activities' do
    activity1 = activities(:simple_activity)
    activity2 = activities(:simple_activity2)

    @content_match.activities << activity1
    activity2.update_attribute(:match_id, @content_match.id)

    assert_equal(2, @content_match.activities.length)
    assert_equal(activity1, @content_match.activities.last)
    assert_equal(activity2, @content_match.activities.first)
    assert_equal(activity1.match, @content_match)
  end

  test 'matches can have teams' do
    team1 = teams(:team1)
    team2 = teams(:team2)

    @content_match.teams << team1
    team2.update_attribute(:match_id, @content_match.id)

    assert_equal(2, @content_match.teams.length)
    assert_equal(team1, @content_match.teams.first)
    assert_equal(team2, @content_match.teams.last)
    assert_equal(team1.match, @content_match)
  end

  test 'matches can have projects' do
    project1 = projects(:simple_project)
    project2 = projects(:simple_project2)

    @project_match.projects << project1
    project2.update_attribute(:match_id, @project_match.id)

    assert_equal(2, @project_match.projects.length)
    assert(@project_match.projects.include?(project2))
    assert(@project_match.projects.include?(project1))
    assert_equal(project1.match, @project_match)
  end

  test 'content matches cannot have projects' do
    project = projects(:simple_project)
    assert_raises 'Project can only exist in project matches' do
      project.update_attribute(match_id: @content_match.id)
    end
  end

  test 'activities can only exist in content matches' do
    activity = activities(:simple_activity)
    assert_raises 'Activity can only exist in project matches' do
      activity.update_attribute(match_id: @content_match.id)
    end
  end

  test 'match is invalid with no match type' do
    @project_match.match_type = nil
    refute @project_match.valid?
  end

  test 'match is valid with all attributes' do
    @project_match.update_attributes(start_date: Date.today + 5.weeks,
                                     end_date: Date.today + 6.weeks)
    assert @project_match.valid?
  end

  test 'match is not valid if it overlaps' do
    match = matches(:active_content_match)

    refute match.valid?
  end

  test 'match is not valid if start_date is bigger than end_date' do
    match = Match.new(match_type: 'Content', start_date: Date.today, end_date: Date.today - 1)
    refute match.valid?
  end

  test 'match cannot be created if it overlaps with another match' do
    match = Match.new(match_type: 'Content', start_date: '2019-04-24', end_date: '2019-04-30')
    refute match.valid?
  end

  test 'match version is assigned automatically when a match is created' do
    match = Match.create(match_type: 'Content', start_date: '2019-05-01', end_date: '2019-05-02')
    assert(3, match.version)
  end

  test 'when user create a match also a poll is created' do
    match = Match.create(match_type: 'Content',
                         start_date: Date.today + 2.weeks,
                         end_date: Date.today + 4.weeks)
    poll = Poll.last
    assert poll.match = match
    assert match.poll = poll
  end

  test 'poll is not created when a match creation fails' do
    match = Match.create(match_type: 'Content',
                         start_date: Date.today,
                         end_date: Date.today)

    refute match.valid?
    refute Poll.find_by(match: match)
  end
end
