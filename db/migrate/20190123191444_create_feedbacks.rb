class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :comment
      t.boolean :status
      t.integer :activity_id

      t.timestamps
    end
    add_index :feedbacks, :activity_id
  end
end
