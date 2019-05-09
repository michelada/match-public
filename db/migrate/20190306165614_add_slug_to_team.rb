class AddSlugToTeam < ActiveRecord::Migration[5.2]
  def up
    add_column :teams, :slug, :string
    add_index :teams, :slug, unique: true

    Team.all.each do |team|
      if team.valid?
        team.slug = team.name.parameterize
        team.save!
      end
    end
  end

  def down
    remove_index :teams, :slug
    remove_column :teams, :slug
  end
end
