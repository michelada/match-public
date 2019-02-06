class AddActivityToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :activity, foreign_key: true, null: false
  end
end
