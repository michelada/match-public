class AddNotesToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :notes, :string
  end
end
