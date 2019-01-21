class AddTypeToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :activity_type, :integer
  end
end
