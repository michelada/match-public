class RemoveTeamIdFromUser < ActiveRecord::Migration[5.2]
  def up
    User.all.each do |user|
      next unless user.team_id

      user.teams << Team.find(user.team_id) if Team.find(user.team_id).match == Match.first
    end
    remove_column :users, :team_id
  end

  def down
    add_reference :users, :team, foreign_key: true
    User.all.each do |user|
      first_team = user.teams.find_by(match: Match.first)
      if first_team
        user.update_attributes!(team_id: first_team.id)
        user.teams.delete(first_team.id)
      end
    end
  end
end
