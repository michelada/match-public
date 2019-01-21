class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :team, optional: true
  has_many :activities
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
