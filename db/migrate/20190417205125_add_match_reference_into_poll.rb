class AddMatchReferenceIntoPoll < ActiveRecord::Migration[5.2]
  def up
    add_reference :polls, :match, foreign_key: true
    match = Match.last

    Poll.all.each do |poll|
      poll.match = match
      poll.save!
    end
  end

  def down
    remove_reference :polls, :match
  end
end
