# == Schema Information
#
# Table name: activities
#
#  id            :bigint(8)        not null, primary key
#  name          :string           not null
#  english       :boolean          not null
#  location      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint(8)
#  activity_type :integer          not null
#  status        :integer          default("Por validar"), not null
#

class Activity < ApplicationRecord
  belongs_to :user 
  validates :name, presence: true
  has_and_belongs_to_many :locations, dependent: :destroy
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
  enum activity_type: { Curso: 0, Platica: 1, Post: 2 }
  enum status: { "Por validar": 0, "Rechazado": 1, "Validado": 2 }
  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
