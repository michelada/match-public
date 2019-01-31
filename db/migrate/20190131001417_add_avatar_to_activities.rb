class AddAvatarToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :activity_file, :string
  end
end
