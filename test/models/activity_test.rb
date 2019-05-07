# == Schema Information
#
# Table name: activities
#
#  id               :bigint(8)        not null, primary key
#  name             :string           not null
#  english          :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)        not null
#  activity_type    :integer          not null
#  status           :integer          default("Por validar"), not null
#  notes            :text
#  score            :integer          default(0)
#  description      :text
#  pitch_audience   :text
#  abstract_outline :text
#  files            :string
#  english_approve  :boolean
#  slug             :string
#  match_id         :bigint(8)
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  setup do
    @match = matches(:content_match)
  end

  test 'workshop and talk must be invalid without user' do
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            match_id: @match.id)
    refute activity.valid?
  end

  test 'workshop and talk must be invalid without name' do
    user = users(:user_test1)
    activity = Activity.new(english: false,
                            activity_type: 0,
                            description: 'The ofician Android Studio IDE',
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            user: user,
                            match_id: @match.id)
    refute activity.valid?
  end

  test 'workshop and talk must be invalid without description' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            user: user,
                            match_id: @match.id)
    refute activity.valid?
  end

  test 'workshop and talk must be invalid without pitch audience' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            user: user,
                            match_id: @match.id)
    refute activity.valid?
  end

  test 'workshop and talk must be invalid without abstract_outline' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            user: user,
                            match_id: @match.id)
    refute activity.valid?
  end

  test 'activity must be invalid without match id' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            user: user)
    refute activity.valid?
  end

  test 'activity must be valid with all attributes' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 0,
                            english: false,
                            description: 'The ofician Android Studio IDE',
                            pitch_audience: 'Estudiantes de tecnologias moviles y responsivas',
                            abstract_outline: 'Intro, getttin-started, activities, MVC',
                            user: user,
                            match_id: @match.id)
    assert activity.valid?
  end

  test 'post must be valid' do
    user = users(:user_test1)
    activity = Activity.new(name: 'Android Studio',
                            activity_type: 2,
                            english: false,
                            user: user,
                            match_id: @match.id)
    assert activity.valid?
  end

  test 'activity must be a workshop' do
    activity = activities(:activity_workshop)

    assert activity.workshop?
  end

  test 'activity must be a talk' do
    activity = activities(:activity_talk)

    assert activity.talk?
  end

  test 'activity must be a post' do
    activity = activities(:activity_post)
    assert activity.post?
  end

  test 'activity must be approved' do
    activity = activities(:activity_workshop)
    assert activity.approved?
  end

  test 'activity is invalid if it belongs to a Project match type' do
    activity = activities(:simple_activity)
    activity.match_id = 2

    refute activity.save
  end
end
