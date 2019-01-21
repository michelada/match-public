class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.boolean :english, null: false
      t.string :location

      t.timestamps
    end
  end
end
