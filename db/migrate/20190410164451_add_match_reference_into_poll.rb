class AddMatchReferenceIntoPoll < ActiveRecord::Migration[5.2]
  def up
    add_reference :polls, :match, foreign_key: true
  end

  def down
    remove_reference :polls, :match
  end
end
