# == Schema Information
#
# Table name: locations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  has_and_belongs_to_many :activity
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
