class MakeFeedbackPolymorphic < ActiveRecord::Migration[5.2]
  def change
    change_table :feedbacks do |t|
      t.remove :activity_id
      t.references :commentable, polymorphic: true, index: true
    end
  end
end
