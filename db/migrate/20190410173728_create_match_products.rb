class CreateMatchProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :match_products do |t|
      t.integer :deliverable_id
      t.string :deliverable_type

      t.timestamps
    end
  end
end
