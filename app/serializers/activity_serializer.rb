class ActivitySerializer < ActiveModel::Serializer
  attributes :name, :location, :created_at, :activity_type, :status
  
  has_many :user
end
