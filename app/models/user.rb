class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :team, optional: true
  has_many :activities
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, validate_on_invite: true
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  enum role: { user: 0, judge: 1, admin: 2 }
end
