class AddScoreToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :score, :int, default: 0
  end
end
