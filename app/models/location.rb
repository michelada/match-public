# == Schema Information
#
# Table name: locations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  approve     :boolean          default(FALSE)
#  activity_id :bigint(8)        not null
#

class Location < ApplicationRecord
  belongs_to :activity
end
