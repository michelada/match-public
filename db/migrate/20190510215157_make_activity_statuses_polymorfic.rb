class MakeActivityStatusesPolymorfic < ActiveRecord::Migration[5.2]
  def up
    rename_table :activity_statuses, :item_approves
    add_reference :item_approves, :item, polymorphic: true, index: true

    ActivityStatus.all.each do |item|
      item.item_type = 'Activity'
      item.item_id = item.activity_id
      item.save!
    end

    remove_column :item_approves, :activity_id
  end

  def down
    add_column :item_approves, :activity_id, :integer
    add_index :item_approves, :activity_id

    ActivityStatus.all.each do |item_approvation|
      item_approvation.activity_id = item_approvation.item_id
      item_approvation.save!
    end
    remove_column :item_approves, :item_id
    remove_column :item_approves, :item_type
    rename_table :item_approves, :activity_statuses
  end
end
