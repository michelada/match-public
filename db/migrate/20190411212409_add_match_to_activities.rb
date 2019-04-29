class AddMatchToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :match, foreign_key: true
    add_reference :projects, :match, foreign_key: true

    reversible do |change|
      change.up do
        match = Match.find_or_create_by(match_type: 'Content',
                                        version: 1,
                                        start_date: '2019-01-15',
                                        end_date: '2019-03-15')
        Activity.where('created_at > ?', '2019-01-15').where('created_at < ?', '2019-03-15').find_each do |activity|
          activity.update_attribute(:match_id, match.id)

          poll = Poll.first || Poll.create(start_date: match.end_date,
                                           end_date: match.end_date + 7.days,
                                           activities_from: match.start_date,
                                           activities_to: match.end_date)
          poll.update_attributes(match_id: match.id)
        end
      end
    end
  end
end
