class RemoveRestrictionsPoll < ActiveRecord::Migration[5.2]
  def up
    remove_column :polls, :activities_from
    remove_column :polls, :activities_to
  end

  def down
    add_column :polls, :activities_from, :date
    add_column :polls, :activities_to, :date
  end
end
