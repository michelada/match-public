class MakeActivityStatusesPolymorfic < ActiveRecord::Migration[5.2]
  def up
    rename_table :activity_statuses, :content_approvations
    add_reference :content_approvations, :content, polymorphic: true, index: true

    ActivityStatus.all.each do |content_status|
      content_status.content = Activity.find(content_status.activity_id)
      content_status.save!
    end

    remove_column :content_approvations, :activity_id
  end

  def down
    add_column :content_approvations, :activity_id, :integer
    add_index :content_approvations, :activity_id

    ActivityStatus.all.each do |content_status|
      content_status.activity_id = content_status.content_id
      content_status.save!
    end
    remove_column :content_approvations, :content_id
    remove_column :content_approvations, :content_type
    rename_table :content_approvations, :activity_statuses
  end
end
