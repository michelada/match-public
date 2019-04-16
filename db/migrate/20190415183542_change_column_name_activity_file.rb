class ChangeColumnNameActivityFile < ActiveRecord::Migration[5.2]
  def up
    rename_column :activities, :activity_file, :files
  end

  def down
    rename_column :activities, :files, :activity_file
  end
end
