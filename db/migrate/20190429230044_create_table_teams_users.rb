class CreateTableTeamsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :teams_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
    end
  end

  def up
    User.all.each do |user|
      if user.team_id
        team = Team.find(user.team_id)
        user.teams << team
      end
    end
    remove_reference :users, :team
  end

  def down
    add_reference :users, :team

    User.all.each do |user|
      if user.teams.any?
        user.team = user.teams.first
        user.save!
      end
    end
  end
end
