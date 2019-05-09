class RemoveRestrictionsPoll < ActiveRecord::Migration[5.2]
  def change
    remove_column :polls, :activities_from
    remove_column :polls, :activities_to
  end
end
