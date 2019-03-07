class CreateActivityStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_statuses do |t|
      t.integer :activity_id, null: false
      t.integer :user_id, null: false
      t.boolean :approve, null: false, default: false

      t.timestamps
    end
    add_index :activity_statuses, :activity_id
    add_index :activity_statuses, :user_id
  end
end
