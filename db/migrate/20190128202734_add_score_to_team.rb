class AddScoreToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :score, :integer
  end
end
