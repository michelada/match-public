class AddApproveLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :approve, :boolean, default: false
  end
end
