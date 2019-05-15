class MakeVotesPolymorphic < ActiveRecord::Migration[5.2]
  def down
    add_column :votes, :activity_id, :integer
    Vote.where(poll: Poll.first).each do |vote|
      vote.update_attributes!(activity_id: vote.content_id)
    end
    change_table :votes do |t|
      t.remove_references :content, polymorphic: true, index: true
    end
  end

  def up
    change_table :votes do |t|
      t.references :content, polymorphic: true, index: true
    end
    Vote.where(poll: Poll.first).each do |vote|
      vote.update_attributes!(content_id: vote.activity_id, content_type: 'Activity')
    end
    remove_column :votes, :activity_id
  end
end
