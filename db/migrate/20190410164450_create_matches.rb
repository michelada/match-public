class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer  :match_type
      t.integer  :version
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
