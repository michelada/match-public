class Activity < ApplicationRecord
  belongs_to :user
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
  enum activity_type: { Curso: 0, Platica: 1, Post: 2 }
  enum status: { "Por validar": 0, "Rechazado": 1, "Validado": 2 }
  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
