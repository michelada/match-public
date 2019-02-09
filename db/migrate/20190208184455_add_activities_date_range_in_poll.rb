class AddActivitiesDateRangeInPoll < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :activities_from, :date, null: false
    add_column :polls, :activities_to, :date, null: false
  end
end
