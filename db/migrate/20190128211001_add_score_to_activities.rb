class AddScoreToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :score, :integer, default: 0
  end
end
