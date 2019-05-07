class ChangeNotesTypeInActivities < ActiveRecord::Migration[5.2]
  def up
    change_column :activities, :notes, :text
  end

  def down
    change_column :activities, :notes, :string
  end
end
