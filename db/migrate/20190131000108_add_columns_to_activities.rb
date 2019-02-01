class AddColumnsToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :description, :text
    add_column :activities, :pitch_audience, :text
    add_column :activities, :abstract_outline, :text
  end
end
