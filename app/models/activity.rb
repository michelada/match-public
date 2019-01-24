class Activity < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :locations, dependent: :destroy
  has_many :feedback
  enum activity_type: { Curso: 0, Platica: 1, Post: 2 }
  enum status: { "Por validar": 0, "Rechazado": 1, "Validado": 2 }
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
