# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint(8)
#  invitations_count      :integer          default(0)
#  team_id                :bigint(8)
#  role                   :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user must be invalid without email' do
    user = User.new(password: 'normalUser',
                    password_confirmation: 'normalUser')
    refute user.valid?
  end

  test 'user must be invalid if email is not from michelada domain' do
    user = User.new(email: 'miguel.urbina@gmail.com',
                    password: 'normalUser',
                    password_confirmation: 'normalUser')
    refute user.valid?
  end

  test 'user must be valid' do
    user = User.new(email: 'miguel.urbina@michelada.io',
                    password: 'normalUser',
                    password_confirmation: 'normalUser')
    assert user.valid?
  end

  test 'user must be a normal user' do
    user = users(:user)
    assert user.normal_user?
  end

  test 'user must be a judge user' do
    user = users(:judge_user)
    assert user.judge?
  end

  test 'user must be an admin user' do
    user = users(:admin_user)
    assert user.admin?
  end

  test 'user has no a team' do
    user = users(:user)
    refute user.team?
  end

  test 'user must have a team' do
    user = users(:user_with_team)
    assert user.team?
  end

  test 'user must be part of a the team' do
    user = users(:user_with_team)
    team = teams(:team3)
    assert user.part_of_team?(team.slug)
  end
  # user judge admin]

  test 'user with no team can be invited to one' do
    user = users(:user)
    assert user.can_be_invited?
  end

  test 'user that is not already registered in system can be invited' do
    user = User.new(email: 'miguel.urbina@michelada.io',
                    password: 'normalUser',
                    password_confirmation: 'normalUser')
    assert user.can_be_invited?
  end
end
