# == Schema Information
#
# Table name: activity_statuses
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer          not null
#  user_id     :integer          not null
#  approve     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ActivityStatusTest < ActiveSupport::TestCase
  def setup
    @judge_user = users(:judge_user)
  end

  test 'Activity status is Por validar as default' do
    match = matches(:active_content_match)
    user = users(:user)
    activity = Activity.new(name: 'Android Studio example',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            pitch_audience: 'All the people who knows how to code eith Java',
                            user: user,
                            match: match)

    activity.save!

    assert_equal 'Por validar', activity.status
  end

  test 'activity change to En revision when create a content status record' do
    activity = activities(:activity_talk)

    activity.approvations.build(user: @judge_user, approve: true)
    activity.save!

    assert_equal 'En revisión', activity.status
  end

  test 'activity change to Aprobada when theres three content statuses record' do
    activity = activities(:activity_talk)

    activity.approvations.build(user: @judge_user, approve: true)
    activity.approvations.build(user: @judge_user, approve: true)
    activity.approvations.build(user: @judge_user, approve: true)
    activity.save!

    assert_equal 'Aprobado', activity.status
  end

  test 'project status is Por valir as default' do
    match = matches(:active_project_match)
    user = users(:user_with_team)
    project = Project.new(name: 'Example project',
                          description: 'Random description for the example project',
                          repositories: 'GitHub-repo, GitLab-repo',
                          features: 'User session',
                          match: match,
                          team: user.current_team)

    project.save!

    assert_equal 'Por validar', project.status
  end

  test 'project status change to En revision when creating a content status record' do
    project = projects(:simple_project)

    project.approvations.build(user: @judge_user, approve: true)
    project.save!

    assert_equal 'En revisión', project.status
  end

  test 'project status stills En revision when theres less than 5 content status records' do
    project = projects(:simple_project)

    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.save!

    assert_equal 'En revisión', project.status
  end

  test 'project status change to Aprobado when theres 5 content status record' do
    project = projects(:simple_project)

    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.approvations.build(user: @judge_user, approve: true)
    project.save!

    assert_equal 'Aprobado', project.status
  end
end
