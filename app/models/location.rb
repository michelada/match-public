class Location < ApplicationRecord
  has_and_belongs_to_many :activity
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
