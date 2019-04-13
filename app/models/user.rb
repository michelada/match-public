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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :team
  belongs_to :match
  has_many :activities, dependent: :destroy
  has_many :activity_statuses
  has_many :feedback, dependent: :destroy
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :validatable, validate_on_invite: true
  VALID_EMAIL_REGEX = /~*@michelada.io\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  enum role: %i[user judge admin]
  scope :all_except_actual, ->(actual_user) { where.not(id: actual_user).order('email ASC') }

  after_invitation_accepted :initialize_user

  def activities
    Activity.user_activities(id)
  end

  def team?
    !team_id.nil?
  end

  def part_of_team?(team_id)
    team&.slug == team_id
  end

  def can_be_invited?
    return true if email.empty?
    return false if User.find_by_email(email)&.team?

    email.match?(VALID_EMAIL_REGEX)
  end

  def initialize_user
    update_attributes!(team_id: invited_by&.team&.id, role: User.roles[:user])
  end
end
