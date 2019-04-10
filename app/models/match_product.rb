# == Schema Information
#
# Table name: match_products
#
#  id               :bigint(8)        not null, primary key
#  deliverable_id   :integer
#  deliverable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  match_id         :bigint(8)
#

class MatchProduct < ApplicationRecord
  belongs_to :deliverable, polymorphic: true
  belongs_to :match
end
