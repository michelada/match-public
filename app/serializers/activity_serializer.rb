class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :created_at, :activity_type, :status
  
  has_many :user
end
