class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :comment
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end
    add_index :feedbacks, :activity_id
    add_index :feedbacks, :user_id
  end
end
