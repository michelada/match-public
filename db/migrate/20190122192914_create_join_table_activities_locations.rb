class CreateJoinTableActivitiesLocations < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :locations do |t|
      # t.index [:activity_id, :location_id]
      # t.index [:location_id, :activity_id]
    end
  end
end
