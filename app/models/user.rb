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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :team, optional: true
  has_many :activities
  has_many :activity_statuses
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :validatable, validate_on_invite: true
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  enum role: { user: 0, judge: 1, admin: 2 }
  scope :all_except_actual, ->(actual_user) { where.not(id: actual_user).order('email ASC') }
end
