class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.text :repositories
      t.text :features

      t.timestamps
    end
  end
end
