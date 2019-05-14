class MakeFeedbackPolymorphic < ActiveRecord::Migration[5.2]
  def up
    change_table :feedbacks do |t|
      t.references :commentable, polymorphic: true, index: true
    end
    Feedback.all.each do |feedback|
      feedback.update_attributes!(commentable_type: 'Activity', commentable_id: feedback.activity_id)
    end
    remove_reference :feedbacks, :activity
  end

  def down
    add_reference :feedbacks, :activity, foreign_key: true
    Feedback.all.each do |feedback|
      feedback.update_attributes!(activity_id: feedback.commentable_id)
    end
    remove_column :feedbacks, :commentable_id
    remove_column :feedbacks, :commentable_type
  end
end
