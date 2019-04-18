class AddMatchReferenceIntoPoll < ActiveRecord::Migration[5.2]
  def up
    add_reference :polls, :match, foreign_key: true
    match = Match.first
    poll = Poll.first || Poll.create(start_date: match.end_date,
                                     end_date: match.end_date + 7.days,
                                     activities_from: match.start_date,
                                     activities_to: match.end_date)
    poll.update_attributes(match_id: match.id)
  end

  def down
    remove_reference :polls, :match
  end
end
