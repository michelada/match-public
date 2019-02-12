class RemoveLocationFromActivities < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :location, :string
  end
end
